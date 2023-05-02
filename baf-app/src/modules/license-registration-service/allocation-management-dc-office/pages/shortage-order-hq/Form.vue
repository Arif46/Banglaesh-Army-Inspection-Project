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
                <th>{{$t('allocation_dc_office.delivery_qty')}}</th>
                <th>{{$t('allocation_dc_office.received_qty')}}</th>
                <th>{{$t('allocation_dc_office.shortage_qty')}}</th>
              </tr>
              </thead>
              <tbody>
                <tr>
                  <td>{{$n(1)}}</td>
                  <td>{{item.details.item_category_id}}</td>
                  <td>{{$n(item.delivered_qty)}}</td>
                  <td v-if="true">
                    <ValidationProvider name="Received Qty" vid="delivered_qty" :rules="`required|min_value:0|max_value: ${item.delivered_qty}`" v-slot="{ errors }">
                      <b-form-group
                        label-for="delivered_qty">
                        <b-form-input
                          id="delivered_qty"
                          type="number"
                          v-model="item.received_amount"
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
                    {{$n(item.received_amount)}}
                  </td>
                  <td class="text-danger" v-if="isOk(item)">{{$n(item.delivered_qty - item.received_amount)}}</td>
                  <td v-else >{{$n(item.delivered_qty - item.received_amount)}}</td>
                </tr>
              </tbody>
            </table>
          </b-col>
        </b-row>
        <br>
        <b-row class="text-right mb-3">
          <b-col>
            <b-button :disabled="btnDisable" type="submit" variant="success" @click="saveData" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
            <b-button variant="danger" class="btn-sm" @click="cancelSubmit">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
      </b-overlay>
  </b-container>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { receiveOrderStoreAgain } from '../../api/routes'
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
       if (this.item.delivered_qty - this.item.received_amount < 0 || this.item.delivered_qty - this.item.received_amount > this.item.delivered_qty) {
            btn = true
          }
      return btn
    }
  },
  watch: {
  },
  methods: {
    isOk (item) {
     return item.delivered_qty - item.received_amount < 0 || item.delivered_qty - item.received_amount > item.delivered_qty
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
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, receiveOrderStoreAgain, this.item)
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
