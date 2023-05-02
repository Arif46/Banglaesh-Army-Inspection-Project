<template>
  <div>
    <b-row>
      <b-col sm="12">
        <div class="quick-filter-wrapper">
          <div class="quick-filter-left">
            <b-dropdown split split-variant="outline-secondary" size="sm" id="dropdown-form" :text="$t('globalTrans.column_visibility')" ref="dropdown">
              <b-dropdown-form>
                <div
                  class="form-group"
                  v-for="(field, index) in labelData"
                  :key="index"
                  >
                    <b-form-checkbox
                      :id="'checkbox-' + field.order"
                      v-model="field.show"
                      :name="'checkbox-' + field.order"
                      value=1
                      unchecked-value=0
                    >
                      {{ field.label }}
                    </b-form-checkbox>
                </div>
              </b-dropdown-form>
            </b-dropdown>
          </div>
          <div class="quick-filter-right">
            <b-form-group
              :label="$t('menu.perpage')"
              label-for="per-page-select"
            >
              <b-form-select
                id="per-page-select"
                v-model="search.limit"
                :options="pageOptions"
                size="sm"
              ></b-form-select>
            </b-form-group>
          </div>
        </div>
      </b-col>
    </b-row>
    <b-row>
      <b-col md="12" class="table-responsive">
        <slot v-if ="columns.filter(item => item.show === '1').length > 0">
          <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty striped bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
            <template v-slot:cell(serial)="data">
              {{ $n(data.index + paginations.slOffset) }}
            </template>
            <template v-slot:cell(is_feature)="data">
                <b-form-checkbox
                  v-model="data.item.is_featured"
                  name="checkbox-1"
                  value="1"
                  unchecked-value="0"
                >
              </b-form-checkbox>
            </template>
            <template v-slot:cell(sorting_order)="data" class="text-center">
              <slot v-if="orderChange == null">
                {{ $n(data.item.sorting_order) }}
              </slot>
              <span class="capitalize" v-else>
                <input @change="checkSortOrder(data.item,$event)"  type="number" :value="data.item.sorting_order"  style="width: 100px;margin:auto" class="form-control text-center"/>
              </span>
            </template>
            <template v-slot:cell(status)="data">
              <span class="badge badge-success" v-if="data.item.status == 1">{{$t('globalTrans.active')}}</span>
              <span class="badge badge-danger" v-else>{{$t('globalTrans.inactive')}}</span>
            </template>
            <template v-slot:cell(action)="data">
              <b-button v-if="actions.edit" v-b-modal.modal-form variant=" iq-bg-success mr-1" size="sm" @click="editData(data.item)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
              <b-button v-if="actions.details" v-b-modal.details variant=" action-btn status mr-1" size="sm" @click="editData(data.item)" class="action-btn edit" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
              <b-button v-if="actions.toogle" variant=" iq-bg-danger" size="sm" @click="removeData(data.item)" class="action-btn delete" :title="$t('globalTrans.delete')"><i class="ri-delete-bin-2-line"></i></b-button>
            </template>
            <template #custom-foot="" v-if="orderChange != null">
              <b-tr>
                <b-th :colspan="orderChange.colspan"></b-th>
                <b-th class="text-center">
                  <button class="btn btn-primary btn-sm" v-on:click="SubmitData()">
                    <i class="fas fa-list"></i>Submit
                  </button>
                </b-th>
                <b-th colspan="2"></b-th>
              </b-tr>
            </template>
          </b-table>
        </slot>
        <div class="pagination-wrapper mt-3" v-if="columns.filter(item => item.show === '1').length > 0">
          <b-pagination
            v-model="paginations.currentPage"
            :perPage="search.limit"
            :total-rows="paginations.totalRows"
            @input="searchData"
          />
          </div>
      </b-col>
    </b-row>
  </div>
</template>
<script>
import ModalBaseMasterList from '@/mixins/list'
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'

export default {
  mixins: [ModalBaseMasterList],
  props: ['labelData', 'columns', 'search', 'searchData', 'paginations', 'actions', 'orderChange', 'imageUrl'],
  data () {
    return {
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      commonServiceBaseUrl: commonServiceBaseUrl,
      editItemId: 0
    }
  },
  computed: {
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    }
  },
  methods: {
    checkSortOrder: function (item, event) {
      if (typeof this.orderChange.checkList !== 'undefined') {
        item.old_serial = item.sorting_order
        item.sorting_order = event.target.value
        // const returnData = OrderCheckModule.OrderCheck(item, this.orderChange.checkList, this.isSave, this.orderChange.type)
        // this.componentList = returnData.moduleListData
        // this.isSave = returnData.isSave
      }
    },
    editData (item) {
      this.$emit('editMethodInParent', item, 1)
    },
    removeData (item) {
      this.$emit('editMethodInParent', item, 2)
    },
    async confirmData () {
      const data = []
      this.listData.map((item, index) => {
        const dataOrder = {
          id: item.id,
          is_featured: item.is_featured,
          sorting_order: item.sorting_order
        }
        data.push(dataOrder)
      })
      let result = null
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      result = await RestApi.postData(commonServiceBaseUrl, this.orderChange.urlSave, data)
      if (result.success) {
        this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
        this.$toast.success({
          title: 'Success',
          message: 'Data saved successfully',
          color: '#D6E09B'
        })
        this.loadData()
      }
    },
    async SubmitData () {
      this.$swal({
        title: this.$t('globalTrans.recommendentChangeMsg'),
        showCancelButton: true,
        confirmButtonText: 'Yes',
        cancelButtonText: 'No',
        focusConfirm: false
      }).then((resultSwal) => {
        if (resultSwal.isConfirmed) {
          this.confirmData()
        }
      })
    }
  }
}
</script>
