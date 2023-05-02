<template>
    <b-container fluid>
        <iq-card>
            <template v-slot:body>
                <div class="row p-2">
                    <div class="col-md-12">
                    <div class="p-2" style="" >
                        <b-overlay>
                        <b-row>
                            <b-col md="12" lg="12" sm="12">
                                <b-card no-body>
                                <b-tabs v-model="tabIndex">
                                    <b-tab v-for="(item, index) in tabData" :key="index" :active="index === 0" @click="tabChange(index)">
                                        <template v-slot:title>
                                        <span>{{ local === 'bn' ? item.tab_title_bn : item.tab_title }}</span>
                                        </template>
                                        <template :id="index">
                                        <b-row>
                                            <b-col md="12" lg="12" sm="12">
                                            <grid-layout :layout.sync="layout"
                                                :col-num="colNum"
                                                :row-height="20"
                                                :is-draggable="false"
                                                :is-resizable="false"
                                                :vertical-compact="true"
                                                :use-css-transforms="true"
                                                :key="layoutKey"
                                            >
                                                <grid-item style="height: auto !important" v-for="(item, dindex) in layout"
                                                :x="item.x"
                                                :y="item.y"
                                                :w="item.w"
                                                :h="item.h"
                                                :i="item.i"
                                                :dataType="item.dataType"
                                                :key="dindex"
                                                >
                                                <Input :tmpData="formIData" :index="dindex" v-if="item.dataType === 'InputField'" />
                                                <Dropdown :data="formIData[dindex]" :drpChangeData="getChildDropdown(dindex)" :nextIndex="dindex + 1" @updateDropdownData="updateDropdown" :key="componentKey" v-if="item.dataType === 'Dropdown'"/>
                                                <Checkbox :data="formIData[dindex]" v-if="item.dataType === 'Checkbox'"/>
                                                <Attachment :data="formIData[dindex]" v-if="item.dataType === 'Attachment'"/>
                                                <Radio :data="formIData[dindex]" v-if="item.dataType === 'Radio'"/>
                                                <Textarea :data="formIData[dindex]" v-if="item.dataType === 'Textarea'"/>
                                                <Paragraph :data="formIData[dindex]" v-if="item.dataType === 'Paragraph'"/>
                                                <Date :data="formIData[dindex]" v-if="item.dataType === 'Date'"/>
                                                <Header :data="formIData[dindex]" v-if="item.dataType === 'Header'"/>
                                                </grid-item>
                                            </grid-layout>
                                            </b-col>
                                        </b-row>
                                        <div class="row">
                                            <AddMoreDetails :tmpData="detailsData" :colData="Addcolumns" v-if="addMore"/>
                                        </div>
                                        </template>
                                    </b-tab>
                                </b-tabs>
                            </b-card>
                        </b-col>
                        </b-row>
                        </b-overlay>
                    </div>
                    </div>
                </div>
            </template>
        </iq-card>
    </b-container>
</template>
<script>
import Input from '@/components/license/user/dissableField/input-field'
import Dropdown from '@/components/license/user/dissableField/dropdown-field-admin'
import Checkbox from '@/components/license/user/dissableField/checkbox-field'
import Attachment from '@/components/license/user/dissableField/attachment-field'
import Radio from '@/components/license/user/dissableField/radio-field'
import Textarea from '@/components/license/user/dissableField/textarea-field'
import Paragraph from '@/components/license/user/dissableField/paragraph-field'
import Date from '@/components/license/user/dissableField/date-field'
import Header from '@/components/license/user/dissableField/header-field'
import AddMoreDetails from '@/components/license/user/dissableField/addMoreDetails'
import { GridLayout, GridItem } from 'vue-grid-layout'
import common from '@/mixins/common'
import CommonLrcpn from '@/mixins/common-lrcpn'
import { snakeToWords } from '@/utils/fliter'
export default {
  mixins: [CommonLrcpn, common],
  props: ['ActionData'],
  components: {
    Input,
    Dropdown,
    Checkbox,
    Attachment,
    GridLayout,
    GridItem,
    Radio,
    Textarea,
    Paragraph,
    Date,
    Header,
    AddMoreDetails
  },
  data () {
    return {
      layout: [],
      layoutData: [],
      layoutEnData: [],
      layoutBnData: [],
      colNum: 12,
      tindex: 0,
      unitLoad: false,
      formInputData: [],
      formInputEnData: [],
      formInputBnData: [],
      formIData: [],
      tabData: [],
      tabIndex: 0,
      componentKey: 0,
      addMore: false,
      detailsData: [],
      Addcolumns: [],
      step_id: '',
      totalTab: 0,
      layoutKey: 0
    }
  },
  created () {
      this.loadFrom()
  },
  watch: {
    tabIndex: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.updateLayout()
      }
    },
    local: function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.updateLayout()
        }
    }
  },
  computed: {
    local: function () {
        return this.$i18n.locale
    }
  },
  methods: {
    loadFrom () {
        this.unitLoad = true
        if (this.ActionData) {
            this.layoutData = []
            this.formInputData = []
            this.tabData = []
            this.ActionData.item.tabs.forEach((item, tabIndex) => {
              const tabNo = item.tab_no
              const tabName = item.tab_name
              const tabTitle = snakeToWords(item.tab_name)
              const data = { tab_no: tabNo, tab_name: tabName, tab_title: tabTitle }
              this.tabData.push(data)
              item.viewlayouts.forEach((layItem) => {
                if (layItem.lang_type === 'en') {
                  const layJson = JSON.parse(layItem.layout)
                  const dataJson = JSON.parse(layItem.data)
                  if (this.ActionData.applicationData !== null) {
                    this.ActionData.applicationData.map((item, index) => {
                        if (item !== null) {
                        this.table_id = item.id
                        Object.keys(item).forEach(key => {
                            if (key === dataJson.field_name) {
                              if (dataJson.field_type === 'options') {
                                Object.assign(dataJson, { value: [item[key]] })
                              } else {
                                Object.assign(dataJson, { value: item[key] })
                              }
                            }
                        })
                        }
                    })
                  }
                  this.layoutEnData.push(layJson)
                  this.formInputEnData.push(dataJson)
                } else {
                  const layJson = JSON.parse(layItem.layout)
                  const dataJson = JSON.parse(layItem.data)
                  if (this.ActionData.applicationData !== null) {
                    this.ActionData.applicationData.map((item, index) => {
                        if (item !== null) {
                        this.table_id = item.id
                        Object.keys(item).forEach(key => {
                            if (key === dataJson.field_name) {
                              if (dataJson.field_type === 'options') {
                                Object.assign(dataJson, { value: [item[key]] })
                              } else {
                                Object.assign(dataJson, { value: item[key] })
                              }
                            }
                        })
                        }
                    })
                  }
                  this.layoutBnData.push(layJson)
                  this.formInputBnData.push(dataJson)
                }
                this.tindex++
              })
            })
            this.totalTab = this.tabData.length - 1
          }
          this.unitLoad = false
          this.updateLayout()
    },
    getChildDropdown (currentIndex) {
      const currentName = this.formIData[currentIndex].dropdownData.dropdown_name
      const child = this.formIData.find((item, index) => (currentIndex < index && item.field_type === 'dropdown' && item.dropdownData.parent_state === currentName))
      return child
    },
    updateDropdown: function (updata, nindex) {
      this.componentKey += 1
    },
    tabChange (val) {
      this.tabIndex = val
      this.updateLayout()
    },
    addMoreDetailsShow (data) {
      if (data) {
        this.detailsData = data
      }
    },
    updateLayout: function (val) {
      this.layout = []
      this.formIData = []
      if (this.$i18n.locale === 'en') {
        this.layoutEnData.map((item, index) => {
          const layData = item.tabIndex === this.tabIndex
          const inpData = this.formInputEnData[index]
          if (layData === true) {
            this.layout.push(item)
            this.formIData.push(inpData)
          }
        })
      }
      if (this.$i18n.locale === 'bn') {
        this.layoutBnData.map((item, index) => {
          const layData = item.tabIndex === this.tabIndex
          const inpData = this.formInputBnData[index]
          if (layData === true) {
            this.layout.push(item)
            this.formIData.push(inpData)
          }
        })
      }
      this.layoutKey = this.layoutKey + 1
    }
  }
}
</script>
<style scoped>
  .vue-grid-item .resizing {
      opacity: 0.9;
  }
  .vue-grid-item .text {
      font-size: 24px;
      text-align: center;
      position: absolute;
      top: 0;
      bottom: 0;
      left: 0;
      right: 0;
      margin: auto;
      height: 100%;
      width: 100%;
  }
  .vue-grid-item .no-drag {
      height: 100%;
      width: 100%;
  }
  .vue-grid-item .minMax {
      font-size: 12px;
  }
  .fields {
    padding: 0.375rem 0.75rem;
  }
  .fields:hover {
    z-index: 1;
    color: #fff;
    background-color: #5a6268;
    border-radius: 0.25rem;
  }
  .dark_button .btn-secondary {
    color: #000 !important;
  }
  hr {
      border: none;
      border-top: 3px double #333;
      color: #333;
      overflow: visible;
      text-align: center;
      height: 5px;
  }
  hr:after {
      background: #fff;
      content: '';
      padding: 0 4px;
      position: relative;
      top: -13px;
  }
</style>
