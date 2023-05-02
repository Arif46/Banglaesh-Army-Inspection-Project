<template>
  <b-container fluid>
    <iq-card class="mt-5">
        <template :id="index">
            <b-overlay :show="unitLoad">
              <div class="row">
                <div class="col-sm-3"></div>
                <div class="col text-right mt-4">
                  <b-button variant="primary" class="mr-4 water-test-pdf-button" style="top: -126px !important" @click="print"><i class="fa fa-print"> {{ $t('globalTrans.print') }} </i></b-button>
                </div>
              </div>
                <b-row>
                    <b-col md="10" lg="10" sm="10" class="offset-1" style="overflow-y: scroll">
                      <div class="mt-4 mb-4" id="printMe">
                        <grid-layout :layout.sync="layout"
                        :col-num="colNum"
                        :row-height="12"
                        :is-draggable="false"
                        :is-resizable="false"
                        :vertical-compact="true"
                        :use-css-transforms="true"
                        v-bind:class="page_pattern"
                        >
                            <grid-item style="height: auto !important" v-for="(item, dindex) in layout"
                                :x="item.x"
                                :y="item.y"
                                :w="item.w"
                                :h="item.h"
                                :i="item.i"
                                :key="dindex"
                            >
                                <b-row>
                                    <commonComponent :Sdata="formInputData[dindex]" :applicantData="applicationData" :layoutData="layoutData"  :key="componentKey"/>
                                </b-row>
                            </grid-item>
                        </grid-layout>
                      </div>
                    </b-col>
                </b-row>
                <div class="row">
                  <div class="col text-right">
                    <b-button variant="danger" class="mr-4" @click="$bvModal.hide('modal-5')">{{ $t('globalTrans.cancel') }}</b-button>
                  </div>
                </div>
            </b-overlay>
        </template>
    </iq-card>
  </b-container>
</template>
<script>
import Vue from 'vue'
import VueHtmlToPaper from 'vue-html-to-paper'
import commonComponent from '../../components/common/commonComponent'
import { GridLayout, GridItem } from 'vue-grid-layout'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { documentView } from '../../api/routes'
import { wordsToSnake, isNotEmpty } from '@/utils/fliter'
Vue.use(VueHtmlToPaper)
export default {
  props: ['pDatas', 'stepID'],
  components: {
    commonComponent,
    GridLayout,
    GridItem
  },
  data () {
    return {
        service_id: 0,
        step_id: 0,
        application_id: 0,
        service_name: '',
        step_name: '',
        applicationData: '',
        layoutData: '',
        layout: [],
        formInputData: [],
        colNum: 12,
        index: 0,
        unitLoad: false,
        loading: false,
        componentKey: 0,
        alignment: 'A4',
        pageType: 'potrait',
        page_pattern: '',
        pageStyle: {
          styles: [
            'https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css'
          ]
        }
    }
  },
  created () {
    this.service_id = parseInt(this.pDatas.service_id)
    this.step_id = parseInt(this.stepID)
    this.application_id = parseInt(this.pDatas.application_id)
    this.service_name = this.getServiceName(parseInt(this.pDatas.service_id))
    this.step_name = this.getStepName(parseInt(this.stepID))
    this.getApplicantDocument()
  },
  methods: {
    print () {
      this.$htmlToPaper('printMe', this.pageStyle)
    },
    getApplicantDocument () {
      this.unitLoad = true
      const params = {
        service_id: this.service_id,
        step_id: this.step_id,
        application_id: this.application_id,
        service_name: this.service_name,
        step_name: this.step_name
      }
      RestApi.getData(licenseRegistrationServiceBaseUrl, documentView, params).then(response => {
        if (isNotEmpty(response.data)) {
            const resultData = response.data
            this.applicationData = response.data.applicantInfo
            this.layoutData = response.data.mainLayout
            this.alignment = response.data.layout.page_size
            if (this.alignment === 'A4') {
              this.pageType = 'potrait'
            } else {
              this.pageType = 'landscape'
            }
            this.page_pattern = response.data.layout.page_size + '_' + response.data.layout.border_pattern
            const CustomCss = `${licenseRegistrationServiceBaseUrl}${this.pageType}.css`
            this.pageStyle.styles.push(CustomCss)
            resultData.layout.document_layouts.forEach((layItem) => {
                const layJson = JSON.parse(layItem.layout)
                const dataJson = JSON.parse(layItem.data)
                this.layout.push(layJson)
                this.formInputData.push(dataJson)
            })
            this.index = this.layout.length
        } else {
            this.$toast.error({
              title: 'Error',
              message: response.message
            })
            this.$bvModal.hide('modal-5')
          }
        this.unitLoad = false
      })
    },
    getServiceName (sId) {
      const service = this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.find(item => item.value === sId)
      return service !== undefined ? wordsToSnake(service.text) : ''
    },
    getStepName (stId) {
      const step = this.$store.state.LicenseRegistrationService.commonObj.stepNamesList.find(item => item.value === stId)
      return step !== undefined ? wordsToSnake(step.text) : ''
    }
  }
}
</script>
<style scoped>
.A4_none {
  width: 838pt !important;
  height: 1200pt !important;
  margin: auto !important;
}
.A4_design_one {
  width: 838pt !important;
  height: 1200pt !important;
  margin: auto !important;
  background: url('../../../../../assets/images/design-one-A4.jpg');
  background-size: cover;
  /* border: 10px solid transparent;
  border-image: url('../../../../../assets/images/border.png') 30 repeat;
  border-image-width: 14px; */
}
.A4_design_two {
  width: 838pt !important;
  height: 1200pt !important;
  margin: auto !important;
  background: url('../../../../../assets/images/design-two-A4.jpg');
  background-size: cover;
  border: 10px solid #01035c;
}
.A4_design_two::before {
  content: '';
  position: absolute;
  left: 4px;
  right: 4px;
  top: 4px;
  bottom: 4px;
  border: 7px solid #564b00;
}
.A4_design_three {
  width: 838pt !important;
  height: 1200pt !important;
  margin: auto !important;
  background: url('../../../../../assets/images/design-three-A4.jpg');
  background-size: cover;
}
.A4_design_four {
  width: 838pt !important;
  height: 1200pt !important;
  margin: auto !important;
  background: url('../../../../../assets/images/design-four-A4.jpg');
  background-size: cover;
}
.landscape_none {
  width: 1200pt !important;
  height: 780pt !important;
  margin: auto !important;
}
.landscape_design_one {
  position: relative;
  width: 1200pt !important;
  height: 780pt !important;
  margin: auto !important;
  background: url('../../../../../assets/images/design-one-landscape.jpg');
  background-size: cover;
}
.landscape_design_two {
  position: relative;
  width: 1200pt !important;
  height: 780pt !important;
  margin: auto !important;
  background: url('../../../../../assets/images/design-two-landscape.jpg');
  background-size: cover;
  border: 10px solid #01035c;
}
.landscape_design_two::before {
  content: '';
  position: absolute;
  left: 4px;
  right: 4px;
  top: 4px;
  bottom: 4px;
  border: 7px solid #564b00;
}
.landscape_design_three {
  position: relative;
  width: 1200pt !important;
  height: 780pt !important;
  margin: auto !important;
  background: url('../../../../../assets/images/design-three-landscape.jpg');
  background-size: cover;
}
.landscape_design_four {
  position: relative;
  width: 1200pt !important;
  height: 780pt !important;
  margin: auto !important;
  background: url('../../../../../assets/images/design-four-landscape.jpg');
  background-size: cover;
}
</style>
