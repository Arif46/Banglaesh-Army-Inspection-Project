<template>
    <div class="table-wrapper table-responsive">
         <h3 class="text-center" style="font-size:22px">Supplier Name - {{ items.supplier_name }}</h3>
        <table class="table table-striped table-hover table-bordered">
            <b-thead>
              <tr>
                <b-th class="text-center">SL NO</b-th>
                <b-th class="text-center">Description</b-th>
                <b-th class="text-center">Specification Specified</b-th>
                <b-th class="text-center">Received Specification</b-th>
                <b-th class="text-center">Verify Status</b-th>
              </tr>
            </b-thead>
            <b-tbody>
            <template v-if="items.supplier_specification_details.length">
              <template v-for="(item, index) in items.supplier_specification_details">
                <b-tr :key="index">
                    <b-td class="text-center">{{ index+1 }}</b-td>
                    <b-td class="text-left">{{ item?.specification_item?.s_description }}</b-td>
                    <b-td class="text-left">{{ item?.specification_item?.s_specified }}</b-td>
                    <b-td class="text-left">{{ item?.received_specification }}</b-td>
                    <b-td class="text-left">{{ getVerifyStatus(item.verify_status) }}</b-td>
                </b-tr>
                <b-tr v-for="(childItem, childIndex) in item.childs" :key="childIndex">
                    <b-td v-if="childIndex === 0" class="text-center" :rowspan="item.childs.length"></b-td>
                    <b-td class="text-left">{{ (childIndex + 10).toString(36) }}) {{ childItem?.specification_item?.s_description }}</b-td>
                    <b-td class="text-left">{{ childItem?.specification_item?.s_specified }}</b-td>
                    <b-td class="text-left">{{ childItem?.received_specification }}</b-td>
                    <b-td class="text-left">{{ getVerifyStatus(childItem.verify_status) }}</b-td>
                </b-tr>
              </template>
            </template>
            </b-tbody>
        </table>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
            <ValidationProvider name="Total Fully Comply" vid="total_fully_comply" v-slot="{ errors }">
              <b-form-group
                label-for="alert_percentage">
                <template v-slot:label>
                  Total Fully Comply
                </template>
                <b-form-input
                style="background-color:#c8ebc8;"
                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                id="total_fully_comply"
                v-model="items.total_fully_comply"
                :state="errors[0] ? false : (valid ? true : null)"
                readonly
                ></b-form-input>
                <div class="invalid-feedback">
                {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
            <ValidationProvider name="Total Partially Comply" vid="total_partially_comply" v-slot="{ errors }">
              <b-form-group
                label-for="alert_percentage">
                <template v-slot:label>
                Total Partially Comply
                </template>
                <b-form-input
                 style="background-color:#9f9f51;"
                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                id="total_partially_comply"
                v-model="items.total_partially_comply"
                :state="errors[0] ? false : (valid ? true : null)"
                readonly
                ></b-form-input>
                <div class="invalid-feedback">
                {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
            <ValidationProvider name="Total Reject" vid="total_reject" v-slot="{ errors }">
              <b-form-group
                label-for="alert_percentage">
                <template v-slot:label>
                Total Reject
                </template>
                <b-form-input
                style="background-color:#d58686;"
                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                id="total_reject"
                v-model="items.total_reject"
                :state="errors[0] ? false : (valid ? true : null)"
                readonly
                ></b-form-input>
                <div class="invalid-feedback">
                {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
        </b-row>
    </div>
</template>
<script>
export default {
    props: ['item'],
    components: {},
    data () {
      return {
      }
    },
    created () {
        this.items = this.item
    },
    methods: {
        getVerifyStatus (status) {
          if (status === 1) {
            return 'Fully Comply'
          } else if (status === 2) {
            return 'Partially Comply'
          } else if (status === 3){
            return 'Reject'
          }
        }
    }
}
</script>
<style scoped>
    .header {
        font-size: 17px;
    }
    .Personal {
        font-size: 25px;
    }
    .break {
        flex-basis: 100%;
        height: 0;
    }
</style>
