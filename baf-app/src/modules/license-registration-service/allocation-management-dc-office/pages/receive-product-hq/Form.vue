<template>
<b-container fluid>
      <b-overlay :show="loading">
        <b-row>
          <b-col>
            <table class="table hover table-bordered">
              <thead class="bg-primary">
              <tr>
                <th>{{$t('globalTrans.sl_no')}}</th>
                <th>{{$t('allocation_management.item_name')}}</th>
                <th>{{$t('allocation_dc_office.allocated_qty')}}</th>
                <th>{{$t('allocation_dc_office.delivery_qty')}}</th>
                <th>{{$t('allocation_dc_office.received_qty')}}</th>
                <th>{{$t('allocation_dc_office.shortage_qty')}}</th>
              </tr>
              </thead>
              <tbody>
              <tr    v-for="(item, index) in item" :key="index">
                <td>{{$n(index + 1)}}</td>
                <td>{{getItemCategoryName(item.item_category_id)}}</td>
                <td>{{$n(item.asking_delivery_qty)}}</td>
                <td>{{$n(item.distribution_qty)}}</td>
                <td v-if="!btnstate">
                  <ValidationProvider name="Received Qty" :vid="`received_${index}`" :rules="`required|min_value:0|max_value: ${item.distribution_qty}`" v-slot="{ errors }">
                  <b-form-group
                    :label-for="`received_${index}`">
                    <b-form-input
                      :id="`received_${index}`"
                      type="number"
                      v-model="item.recieved_qty"
                      oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                      :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
                </td>
                <td v-else>
                  {{$n(item.recieved_qty)}}
                </td>
                <td class="text-danger" v-if="isOk(item)">{{$n(item.distribution_qty - item.recieved_qty)}}</td>
                <td v-else >{{$n(item.distribution_qty - item.recieved_qty)}}</td>
              </tr>
              </tbody>
            </table>
          </b-col>
        </b-row>
        <br>
        <b-row class="text-right mb-3">
          <b-col>
            <b-button v-if="!btnstate" :disabled="btnDisable" type="submit" variant="success" @click="saveData" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
            <b-button variant="danger" class="btn-sm" @click="cancelSubmit">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
      </b-overlay>
  </b-container>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { receiveOrderStore } from '../../api/routes'
export default {
  name: 'Form',
  props: ['item', 'btnstate'],
  data () {
    return {
      valid: null,
      saveBtnName: this.$t('globalTrans.save'),
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      errors: [],
      itemList: [],
      loading: false
    }
  },
  created () {
  },
  computed: {
    btnDisable: function () {
      let btn = false
        this.item.map((item, index) => {
          if (item.distribution_qty - item.recieved_qty < 0 || item.distribution_qty - item.recieved_qty > item.distribution_qty) {
            btn = true
          }
      })
      return btn
    }
  },
  watch: {
  },
  methods: {
    isOk (item) {
     return item.distribution_qty - item.recieved_qty < 0 || item.distribution_qty - item.recieved_qty > item.distribution_qty
    },
    getItemName (itemId, lang = this.$i18n.locale) {
      const item = this.$store.state.LicenseRegistrationService.commonObj.itemList.find(item => item.value === itemId)
      if (item !== undefined) {
        if (lang === 'bn') {
          return item.text_bn
        } else {
          return item.text_en
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
    },
    cancelSubmit () {
      this.$bvModal.hide('modal-form')
    },
    saveData () {
      this.$swal({
        title: this.$t('globalTrans.final_save_msg'),
        showCancelButton: true,
        confirmButtonText: this.$t('globalTrans.yes'),
        cancelButtonText: this.$t('globalTrans.no'),
        focusConfirm: false
      }).then((resultSwal) => {
        if (resultSwal.isConfirmed) {
          this.saveUpdate()
        }
      })
    },
    async saveUpdate () {
        this.loading = true
        let result = null
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, receiveOrderStore, this.item)
        if (result.success) {
          this.loading = false
          this.$toast.success({
            title: this.$t('globalTrans.success'),
            message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
            color: '#D6E09B'
          })
          this.$bvModal.hide('modal-form')
        } else {
          this.loading = false
          this.$refs.mainForm.setErrors(result.errors)
        }
    }
  }
}
</script>
