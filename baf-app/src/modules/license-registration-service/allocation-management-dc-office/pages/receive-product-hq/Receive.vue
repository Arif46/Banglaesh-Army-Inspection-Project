<template>
  <b-container fluid>
    <b-row>
      <b-col sm="12" class="mt-3">
        <b-overlay :show="loading">
          <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
            <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset">
              <table class="table table-bordered">
                <tr class="tboder bg-primary font-weight-bold">
                    <td style="width:10%;" class="tboder">{{ $t('globalTrans.sl_no') }}</td>
                    <td class="tboder">&nbsp;{{ $t('stock_management.item_category') }}</td>
                    <td class="tboder">&nbsp;{{ $t('allocation_management.item_name') }}</td>
                    <td class="tboder">{{ $t('allocation_management.allocated_quantity') }} ({{$t('allocation_dc_office.unit')}})</td>
                    <td class="tboder">{{ $t('allocation_dc_office.delivery_qty') }} ({{$t('allocation_dc_office.unit')}})</td>
                    <td class="tboder">{{ $t('allocation_dc_office.received_qty') }} ({{$t('allocation_dc_office.unit')}})</td>
                    <td class="tboder">{{ $t('allocation_dc_office.shortage_qty') }} ({{$t('allocation_dc_office.unit')}})</td>
                </tr>
                <template v-if="receiveProduct.details.length > 0">
                <tr class="tboder" v-for="(detail,index) in receiveProduct.details" :key="index">
                    <td style="vertical-align : middle;text-align:center">{{ $n(index+1) }}</td>
                    <td style="vertical-align : middle;text-align:center" width="15%">{{ getItemCategoryName(detail.item_category_id) }}</td>
                    <td style="vertical-align : middle;text-align:center" width="15%">{{ getItemName(detail.item_id) }}</td>
                    <td style="vertical-align : middle;text-align:center">{{ $n(detail.asking_delivery_qty, { useGrouping: false }) }}</td>
                    <td style="vertical-align : middle;text-align:center">{{ $n(detail.distribution_qty, { useGrouping: false }) }}</td>
                    <td style="vertical-align : middle;text-align:center">
                        <ValidationProvider name="Receive Quantity" :vid="`received_qty_${index}`" :rules="`required|min_value:0|max_value: ${detail.distribution_qty}`" v-slot="{ errors }">
                            <b-form-group
                            class="row"
                            label-cols-sm="1"
                            :label-for="`received_qty_${index}`"
                            >
                            <b-form-input
                              :id="`received_qty_${index}`"
                                v-model="detail.recieved_qty"
                                :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                            <div class="invalid-feedback">
                            {{ errors[0] }}
                            </div>
                              <span class="text-danger">{{ValidCheck(detail)}}</span>
                            </b-form-group>
                        </ValidationProvider>
                    </td>
                    <td style="vertical-align : middle;text-align:center">{{ getShortageQuantity(detail) }}</td>
                </tr>
                </template>
              </table>
              <b-row class="text-right">
                <b-col md="12">
                <b-button :disabled="!CheckAll" type="submit" variant="primary" class="btn-sm mr-2">{{ $t('globalTrans.receive') }}</b-button>
                <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-5')">{{ $t('globalTrans.cancel') }}</b-button>
                </b-col>
              </b-row>
          </b-form>
        </ValidationObserver>
      </b-overlay>
      </b-col>
    </b-row>
  </b-container>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { receiveProductStore } from '../../api/routes'
export default {
    props: ['id'],
    components: {
    },
    created () {
      if (this.id) {
        const tmp = this.getData()
        this.receiveProduct = tmp
      }
    },
    data () {
        return {
            allotmentOrderData: [],
            licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
            receiveProduct: {}
        }
    },
    computed: {
        currentLocale () {
          return this.$i18n.locale
        },
        loading: function () {
          return this.$store.state.commonObj.loading
        },
        CheckAll: function () {
          let st = true
          const cateObj = this.$store.state.LicenseRegistrationService.commonObj.itemList
          this.receiveProduct.details.map(function (item, index) {
            const dat = cateObj.filter(it => it.status === 1).find(it => it.value === item.item_id)
            if (item.recieved_qty > 0) {
              if (item.recieved_qty % dat.unit_actual_value !== 0) {
              st = false
              }
            }
          })
          return st
        }
    },
    methods: {
      ValidCheck (data) {
        const cateObj = this.$store.state.LicenseRegistrationService.commonObj.itemList.filter(item => item.status === 1)
          .find(item => item.value === data.item_id).unit_actual_value
        if (data.recieved_qty > 0) {
          if (data.recieved_qty % cateObj !== 0) {
            return this.$i18n.locale === 'bn' ? 'পরিমাণ অবশ্যই ' + this.$n(cateObj) + ' এর গুণিতক হতে হবে' : 'The amount must be a multiple of ' + cateObj
          }
        }
        // receiveProduct.details
      },
        getData () {
          const tmpData = this.$store.state.list.find(item => item.id === parseInt(this.id))
          return JSON.parse(JSON.stringify(tmpData))
        },
        getShortageQuantity (data) {
          const result = data.distribution_qty - data.recieved_qty
          return this.$n(result)
        },
        async saveUpdate () {
          this.$store.dispatch('mutateCommonProperties', { loading: true })
          this.loading = true
          let result = null
          const loadingState = { loading: false, listReload: true }
          result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${receiveProductStore}/${this.receiveProduct.id}`, this.receiveProduct)
          this.$store.dispatch('mutateCommonProperties', loadingState)
          if (result.success) {
            this.$store.dispatch('LicenseRegistrationService/mutateCommonObj', { hasDropdownLoaded: false })
            this.loading = false
            this.$toast.success({
              title: this.$t('globalTrans.success'),
              message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
              color: '#D6E09B'
            })
            this.$bvModal.hide('modal-5')
          } else {
            this.loading = false
            this.$refs.form.setErrors(result.errors)
          }
        },
        getItemName (itemCategoryId) {
          const cateObj = this.$store.state.LicenseRegistrationService.commonObj.itemList.filter(item => item.status === 1).find(item => item.value === itemCategoryId)
          if (cateObj !== undefined) {
            if (this.$i18n.locale === 'bn') {
              return cateObj.text_bn
            } else {
              return cateObj.text_en
            }
          }
        },
      getItemCategoryName (itemCategoryId, lang = this.$i18n.locale) {
        const cateObj = this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.filter(item => item.status === 1).find(item => item.value === itemCategoryId)
        if (cateObj !== undefined) {
          if (lang === 'bn') {
            return cateObj.text_bn
          } else {
            return cateObj.text_en
          }
        }
      }
    }
}

</script>
