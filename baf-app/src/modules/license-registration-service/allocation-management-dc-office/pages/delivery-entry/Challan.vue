<template>
  <b-container fluid>
    <b-overlay>
      <b-col v-if="loadHistory" md="12" lg="12" sm="12">
        <b-overlay :show="true" class="p-5">
          <div class="text-center">
            <h5> {{ $t('externalLrcpn.receipt_checking') }} </h5>
          </div>
        </b-overlay>
      </b-col>
      <b-col v-else md="12" lg="12" sm="12">
        <div>
          <b-tabs content-class="mt-3">
            <span v-for="(deliverItem, index) in item.delivery_items" :key="index">
              <b-tab :title="`${$t('allocation_dc_office.challan')} - ${$n(deliverItem.challan_id, {useGrouping: false})}`">
                <ChallanView :items="item" :challan_id="deliverItem.challan_id" />
              </b-tab>
            </span>
          </b-tabs>
        </div>
        <div class="row mt-3">
          <div class="col-md-12 text-right">
            <b-button variant="danger" class="mr-1 mt-3" @click="$bvModal.hide('challan-view')">{{ $t('globalTrans.cancel') }}</b-button>
          </div>
        </div>
      </b-col>
    </b-overlay>
  </b-container>
</template>
<script>
import ChallanView from './ChallanView.vue'
export default {
  name: 'Challan',
  props: ['item'],
  components: {
    ChallanView
  },
   data () {
    return {
        loadHistory: false,
        history: [],
        receipt: {}
    }
  },
  created () {
  },
  methods: {
  }
}
</script>
