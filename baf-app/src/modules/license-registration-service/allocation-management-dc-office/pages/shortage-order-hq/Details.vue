<template>
  <b-container fluid>
    <b-row>
      <b-col sm="12" class="mt-3">
        <b-overlay :show="loading">
          <table class="table table-bordered text-center">
            <tr class="tboder bg-primary">
              <td style="width:15%;" class="tboder">{{ $t('globalTrans.sl_no') }}</td>
              <td class="tboder">&nbsp;{{ $t('stock_management.item_category') }}</td>
              <td class="tboder">{{ $t('allocation_dc_office.shortage_qty') }} ({{$t('allocation_dc_office.unit')}})</td>
              <td class="tboder">{{ $t('allocation_dc_office.delivery_qty') }} ({{$t('allocation_dc_office.unit')}})</td>
              <td class="tboder">{{ $t('allocation_dc_office.received_qty') }} ({{$t('allocation_dc_office.unit')}})</td>
            </tr>
            <template v-if="receiveProduct.length > 0">
              <tr class="tboder" v-for="(detail,index) in [...new Set( receiveProduct.map(obj => obj.item_category_id)) ]" :key="index">
                <td style="vertical-align : middle;text-align:center">{{ $n(index+1) }}</td>
                <td style="vertical-align : middle;text-align:center" width="15%">{{ getItemCategoryName(detail) }}</td>
                <td style="vertical-align : middle;text-align:center">{{ $n(shoratgeAmount(detail)) }}</td>
                <td style="vertical-align : middle;text-align:center">{{ $n(deliverAmount(detail)) }}</td>
                <td style="vertical-align : middle;text-align:center">{{ $n(receivedAmount(detail)) }}</td>
              </tr>
            </template>
          </table>
          <b-row class="text-right">
            <b-col>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('details')">{{ $t('globalTrans.cancel') }}</b-button>
            </b-col>
          </b-row>
        </b-overlay>
      </b-col>
    </b-row>
  </b-container>
</template>
<script>
  export default {
    props: ['id'],
    components: {
    },
    created () {
      if (this.id) {
        const info = []
        const info2 = []
        const receiveProduct = []
        this.id.details.forEach((element, index) => {
          this.form.main_id = element.delivery_entry_id
          if (element.shortage) {
            info.push({
              short_id: element.shortage.id,
              received_amount: element.shortage_qty
            })
            info2.push({
              id: element.id,
              recieved_qty: element.shortage_qty
            })
            receiveProduct.push({
              item_category_id: element.item_category_id,
              item_id: element.item_id,
              shortage_amount: element.shortage.shortage_amount,
              delivered_qty: element.shortage.delivered_qty,
              received_amount: element.shortage.received_amount
            })
          }
        })
        this.form.details = info2
        this.form.shortage = info
        this.receiveProduct = receiveProduct
      }
    },
    data () {
      return {
        allotmentOrderData: [],
        receiveProduct: {},
        form: {
          main_id: null,
          details: [],
          shortage: []
        }
      }
    },
    computed: {
      currentLocale () {
        return this.$i18n.locale
      },
      loading: function () {
        return this.$store.state.commonObj.loading
      }
    },
    methods: {
      shoratgeAmount (cat) {
        let t = 0
        this.receiveProduct.filter(item => item.item_category_id === cat).map(function (element, index) {
          t += element.shortage_amount
        })
        return t
      },
      deliverAmount (cat) {
        let t = 0
        this.receiveProduct.filter(item => item.item_category_id === cat).map(function (element, index) {
          t += element.delivered_qty
        })
        return t
      },
      receivedAmount (cat) {
        let t = 0
        this.receiveProduct.filter(item => item.item_category_id === cat).map(function (element, index) {
          t += element.received_amount
        })
        return t
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
