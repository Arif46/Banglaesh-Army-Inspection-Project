<template>
    <b-row style="margin-left:10px;font-size: 22px;">
        <b-col md="12" sm="12" lg="12" :class="pageData[0].align">
            <span class="col-sm-12 text-center text-dark fields" v-for="(item, index) in pageData" :key="index" style="margin:0px;padding:0px;">
                <p v-if="item.type === 'Empty'"></p>
                <span v-if="item.type === 'Paragraph' || item.type === 'InputField' || item.type === 'DocumentID'" :style="{ color: item.color, 'font-weight': getFontWeight(item)}">{{ item.value }}</span>
                <span v-if="item.type === 'Date'" :style="{ color: item.color}">{{ dateFormat(item.value) }}</span>
                <span v-if="item.type === 'FirstIssueDate'" :style="{ color: item.color}">{{ item.value ? dateFormat(item.value) : '' }}</span>
                    <h1 v-if="item.field_type === 'h1'" :style="{ color: item.color}">{{ item.value }}</h1>
                    <h2 v-if="item.field_type === 'h2'" :style="{ color: item.color}">{{ item.value }}</h2>
                    <h3 v-if="item.field_type === 'h3'" :style="{ color: item.color}">{{ item.value }}</h3>
                    <h4 v-if="item.field_type === 'h4'" :style="{ color: item.color}">{{ item.value }}</h4>
                    <h5 v-if="item.field_type === 'h5'" :style="{ color: item.color}">{{ item.value }}</h5>
                    <h6 v-if="item.field_type === 'h6'" :style="{ color: item.color}">{{ item.value }}</h6>
                    <table class="table table-bordered" v-if="item.type === 'Table'">
                        <tr v-for="(col, index) in item.column" :key="index">
                            <td>{{ col.label }}</td>
                            <td>{{ col.value }}</td>
                        </tr>
                    </table>
                    <vue-qrcode :value="qr_code" style="max-width: 100%;max-height: 100%;" v-if="item.type === 'QR'"/>
                    <img v-if="item.type === 'Attachment' && item.field_type === 'dynamic'" :src="lrcpanBaseUrl + 'uploads/lrcpn/' + item.value" style="max-width: 100%;max-height: 100%;text-align: center;" alt="Image">
                    <img v-if="item.type === 'Attachment' && item.field_type === 'static'" :src="item.value" style="max-width: 100%;max-height: 100%;text-align: center;">
            </span>
        </b-col>
    </b-row>
</template>
<script>
import VueQrcode from 'vue-qrcode'
import { dateFormat } from '@/utils/fliter.js'
import common from '@/mixins/common'
import { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
export default {
    mixins: [common],
    props: ['Sdata', 'applicantData', 'layoutData'],
    components: {
        VueQrcode
    },
    data () {
        return {
            pageData: '',
            qr_code: '',
            lrcpanBaseUrl: licenseRegistrationServiceBaseUrl
        }
    },
    computed: {
        local: function () {
            return this.$i18n.locale
        }
    },
    watch: {
        local: function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.getLanguateWisedata()
            }
        }
    },
    created () {
        if (this.Sdata) {
            this.pageData = this.Sdata
            this.pageData.forEach(item => {
                if (item.type === 'Table') {
                    Object.keys(this.applicantData).forEach(keyname => {
                        return item.column.forEach(colItem => {
                            if (colItem.value === keyname) {
                                colItem.value = this.applicantData[keyname]
                            }
                        })
                    })
                } else if (item.type === 'QR') {
                    Object.keys(this.applicantData).forEach(keyname => {
                        return item.column.forEach(colItem => {
                            if (colItem.value === keyname) {
                                colItem.value = this.applicantData[keyname]
                                if (this.qr_code === '') {
                                    this.qr_code = colItem.label + ': ' + colItem.value
                                } else if (colItem.label.match('Mobile')) {
                                    if (this.local === 'bn') {
                                        this.qr_code = this.qr_code + ',' + colItem.label + ': ০' + colItem.value
                                    } else {
                                        this.qr_code = this.qr_code + ',' + colItem.label + ': 0' + colItem.value
                                    }
                                } else {
                                    this.qr_code = this.qr_code + ',' + colItem.label + ': ' + colItem.value
                                }
                            }
                        })
                    })
                } else {
                    Object.keys(this.applicantData).forEach(keyname => {
                        return this.pageData.map(sitem => {
                            if (this.$i18n.locale === 'en') {
                                if (sitem.columnId !== '' && sitem.column === keyname && sitem.columnBn !== keyname) {
                                    const laydata = this.layoutData.find(i => i.id === parseInt(sitem.columnId))
                                    const data = JSON.parse(laydata.data)
                                    if (data.field_type === 'dropdown') {
                                        if (data.dropdownData.component_id === '0') {
                                            const dropDowns = data.dropdownData.dropdown_options
                                            const drpValue = dropDowns[this.applicantData[keyname]]
                                            if (this.$i18n.locale === 'bn') {
                                                sitem.value = drpValue.name_bn
                                            } else {
                                                sitem.value = drpValue.name_bn
                                            }
                                        } else if (data.dropdownData.component_id === '1') {
                                            const drpvalue = this.getCommonStoreData(data.dropdownData.dropdown_name, this.applicantData[keyname])
                                            sitem.value = drpvalue
                                        } else {
                                            sitem.value = this.applicantData[keyname]
                                        }
                                    } else if (data.field_type === 'number') {
                                        sitem.value_en = this.applicantData[keyname]
                                        sitem.value_bn = this.$n(this.applicantData[keyname], { useGrouping: false })
                                        sitem.value = sitem.value_en
                                    } else {
                                        sitem.value = this.applicantData[keyname]
                                    }
                                } else if (sitem.columnId === '' && sitem.column === keyname) {
                                    if (keyname === 'generate_id') {
                                        const prefix = this.$store.state.ExternalUserService.dealerPanel.commonObj.autoGenNumTypeList.find(item => item.service_name_id === this.applicantData.service_id)
                                        const issueId = this.$n(this.applicantData[keyname], { useGrouping: false })
                                        sitem.value = prefix.prefix + ' - ' + issueId
                                    } else if (keyname === 'issue_date') {
                                        sitem.value = this.applicantData[keyname]
                                    } else if (keyname === 'expire_date') {
                                        sitem.value = this.applicantData[keyname]
                                    } else {
                                        sitem.value = this.applicantData[keyname]
                                    }
                                } else if (sitem.columnId === '' && sitem.column !== keyname) {
                                    if (sitem.type === 'Attachment') {
                                        const val = sitem.value
                                        sitem.value = val
                                    } else if (sitem.type !== 'DocumentID' && sitem.type !== 'Date' && sitem.type !== 'FirstIssueDate') {
                                        sitem.value = sitem.value_en
                                    }
                                } else if (sitem.columnId !== '' && sitem.columnBn === sitem.column && sitem.columnBn === keyname) {
                                    const laydata = this.layoutData.find(i => i.id === parseInt(sitem.columnId))
                                    const data = JSON.parse(laydata.data)
                                    if (data.field_type === 'paymentCheckbox') {
                                        const options = data.dropdownData.dropdown_options.map((item) => {
                                            if (this.$i18n.locale === 'bn') {
                                                return item.type_name_bn
                                            } else {
                                                return item.type_name
                                            }
                                        })
                                        const datas = []
                                        options.forEach((item, index) => {
                                            JSON.parse(this.applicantData[keyname]).forEach(tmp => {
                                                if (index === tmp) {
                                                datas.push(item)
                                                }
                                            })
                                        })
                                        const value = datas.join(', ')
                                        sitem.value = value
                                    } else if (data.field_type === 'payment') {
                                        const options = data.dropdownData.dropdown_options.map((item) => {
                                            if (this.$i18n.locale === 'bn') {
                                                return item.type_name_bn
                                            } else {
                                                return item.type_name
                                            }
                                        })
                                        const datas = options.filter((item, index) => index === parseInt(this.applicantData[keyname]))
                                        const value = datas.join(', ')
                                        sitem.value = value
                                    } else if (data.field_type === 'number') {
                                        sitem.value_en = this.applicantData[keyname]
                                        sitem.value_bn = this.$n(this.applicantData[keyname], { useGrouping: false })
                                        sitem.value = sitem.value_en
                                    } else if (data.field_type === 'dropdown') {
                                        if (data.dropdownData.component_id === '0') {
                                            const dropDowns = data.dropdownData.dropdown_options
                                            const drpValue = dropDowns[this.applicantData[keyname]]
                                            if (this.$i18n.locale === 'bn') {
                                                sitem.value = drpValue.name_bn
                                            } else {
                                                sitem.value = drpValue.name_bn
                                            }
                                        } else if (data.dropdownData.component_id === '1') {
                                            const drpvalue = this.getCommonStoreData(data.dropdownData.dropdown_name, this.applicantData[keyname])
                                            sitem.value = drpvalue
                                        } else {
                                            sitem.value = this.applicantData[keyname]
                                        }
                                    } else {
                                        sitem.value = this.applicantData[keyname]
                                    }
                                }
                            } else if (this.$i18n.locale === 'bn') {
                                if (sitem.columnBId !== '' && sitem.columnBn === keyname && sitem.column !== keyname) {
                                    const laydata = this.layoutData.find(i => i.id === parseInt(sitem.columnBId))
                                    const data = JSON.parse(laydata.data)
                                    if (data.field_type === 'dropdown') {
                                        if (data.dropdownData.component_id === '0') {
                                            const dropDowns = data.dropdownData.dropdown_options
                                            const drpValue = dropDowns[this.applicantData[keyname]]
                                            if (this.$i18n.locale === 'bn') {
                                                sitem.value = drpValue.name_bn
                                            } else {
                                                sitem.value = drpValue.name_bn
                                            }
                                        } else if (data.dropdownData.component_id === '1') {
                                            const drpvalue = this.getCommonStoreData(data.dropdownData.dropdown_name, this.applicantData[keyname])
                                            sitem.value = drpvalue
                                        } else {
                                            sitem.value = this.applicantData[keyname]
                                        }
                                    } else if (data.field_type === 'number') {
                                        sitem.value_en = this.applicantData[keyname]
                                        sitem.value_bn = this.$n(this.applicantData[keyname], { useGrouping: false })
                                        sitem.value = sitem.value_bn
                                    } else {
                                        sitem.value = this.applicantData[keyname]
                                    }
                                } else if (sitem.columnId === '' && sitem.columnBn === keyname) {
                                    if (keyname === 'generate_id') {
                                        const prefix = this.$store.state.ExternalUserService.dealerPanel.commonObj.autoGenNumTypeList.find(item => item.service_name_id === this.applicantData.service_id)
                                        const issueId = this.$n(this.applicantData[keyname], { useGrouping: false })
                                        sitem.value = prefix.prefix + ' - ' + issueId
                                    } else {
                                        sitem.value = this.applicantData[keyname]
                                    }
                                } else if (sitem.columnId === '' && sitem.columnBn !== keyname) {
                                    if (sitem.column === 'issue_date' && keyname === 'issue_date') {
                                        const val = this.applicantData[keyname]
                                        sitem.value = val
                                    } else if (sitem.column === 'expire_date' && keyname === 'expire_date') {
                                        const val = this.applicantData[keyname]
                                        sitem.value = val
                                    } else if (sitem.type === 'Attachment' && sitem.field_type === 'dynamic') {
                                        if (keyname === item.column) {
                                            sitem.value = this.applicantData[keyname]
                                        }
                                    } else if (sitem.type === 'Attachment' && sitem.field_type === 'static') {
                                        const val = sitem.value
                                        sitem.value = val
                                    } else if (sitem.type !== 'DocumentID' && sitem.type !== 'Date') {
                                        sitem.value = sitem.value_bn
                                    }
                                } else if (sitem.columnId !== '' && sitem.columnBn === sitem.column && sitem.columnBn === keyname) {
                                    const laydata = this.layoutData.find(i => i.id === parseInt(sitem.columnId))
                                    const data = JSON.parse(laydata.data)
                                    if (data.field_type === 'paymentCheckbox') {
                                        const options = data.dropdownData.dropdown_options.map((item) => {
                                            if (this.$i18n.locale === 'bn') {
                                                return item.type_name_bn
                                            } else {
                                                return item.type_name
                                            }
                                        })
                                        const datas = []
                                        options.forEach((item, index) => {
                                            JSON.parse(this.applicantData[keyname]).forEach(tmp => {
                                                if (index === tmp) {
                                                datas.push(item)
                                                }
                                            })
                                        })
                                        const value = datas.join(', ')
                                        sitem.value = value
                                    } else if (data.field_type === 'payment') {
                                        const options = data.dropdownData.dropdown_options.map((item) => {
                                            if (this.$i18n.locale === 'bn') {
                                                return item.type_name_bn
                                            } else {
                                                return item.type_name
                                            }
                                        })
                                        const datas = options.filter((item, index) => index === parseInt(this.applicantData[keyname]))
                                        const value = datas.join(', ')
                                        sitem.value = value
                                    } else if (data.field_type === 'number') {
                                        sitem.value_en = this.applicantData[keyname]
                                        sitem.value_bn = this.$n(this.applicantData[keyname], { useGrouping: false })
                                        sitem.value = sitem.value_bn
                                    } else if (data.field_type === 'dropdown') {
                                        if (data.dropdownData.component_id === '0') {
                                            const dropDowns = data.dropdownData.dropdown_options
                                            const drpValue = dropDowns[this.applicantData[keyname]]
                                            if (this.$i18n.locale === 'bn') {
                                                sitem.value = drpValue.name_bn
                                            } else {
                                                sitem.value = drpValue.name_bn
                                            }
                                        } else if (data.dropdownData.component_id === '1') {
                                            const drpvalue = this.getCommonStoreData(data.dropdownData.dropdown_name, this.applicantData[keyname])
                                            sitem.value = drpvalue
                                        } else {
                                            sitem.value = this.applicantData[keyname]
                                        }
                                    } else {
                                        sitem.value = this.applicantData[keyname]
                                    }
                                }
                            }
                        })
                    })
                }
            })
        }
    },
    methods: {
        dateFormat (val) {
            return dateFormat(val)
        },
        getFontWeight (item) {
            if (item.is_bold === true) {
                return 'bold'
            } else {
                return 'normal'
            }
        },
        getLanguateWisedata () {
            this.pageData.forEach(item => {
                if (item.type === 'Table') {
                    Object.keys(this.applicantData).forEach(keyname => {
                        return item.column.forEach(colItem => {
                            if (colItem.value === keyname) {
                                colItem.value = this.applicantData[keyname]
                            }
                        })
                    })
                } else if (item.type === 'QR') {
                    Object.keys(this.applicantData).forEach(keyname => {
                        return item.column.forEach(colItem => {
                            if (colItem.value === keyname) {
                                colItem.value = this.applicantData[keyname]
                                if (this.qr_code === '') {
                                    this.qr_code = colItem.value
                                } else {
                                    this.qr_code = this.qr_code + ',' + colItem.value
                                }
                            }
                        })
                    })
                } else {
                    Object.keys(this.applicantData).forEach(keyname => {
                        return this.pageData.map(sitem => {
                            if (this.$i18n.locale === 'en') {
                                if (sitem.columnId !== '' && sitem.column === keyname && sitem.columnBn !== keyname) {
                                    const laydata = this.layoutData.find(i => i.id === parseInt(sitem.columnId))
                                    const data = JSON.parse(laydata.data)
                                    if (data.field_type === 'dropdown') {
                                        if (data.dropdownData.component_id === '0') {
                                            const dropDowns = data.dropdownData.dropdown_options
                                            const drpValue = dropDowns[this.applicantData[keyname]]
                                            if (this.$i18n.locale === 'bn') {
                                                sitem.value = drpValue.name_bn
                                            } else {
                                                sitem.value = drpValue.name_bn
                                            }
                                        } else if (data.dropdownData.component_id === '1') {
                                            const drpvalue = this.getCommonStoreData(data.dropdownData.dropdown_name, this.applicantData[keyname])
                                            sitem.value = drpvalue
                                        } else {
                                            sitem.value = this.applicantData[keyname]
                                        }
                                    } else {
                                        sitem.value = this.applicantData[keyname]
                                    }
                                } else if (sitem.columnId === '' && sitem.column === keyname) {
                                    if (keyname === 'generate_id') {
                                        const prefix = this.$store.state.ExternalUserService.dealerPanel.commonObj.autoGenNumTypeList.find(item => item.service_name_id === this.applicantData.service_id)
                                        sitem.value = prefix.prefix + ' - ' + this.$n(this.applicantData[keyname])
                                    } else if (keyname === 'issue_date') {
                                        sitem.value = this.applicantData[keyname]
                                    } else if (keyname === 'expire_date') {
                                        sitem.value = this.applicantData[keyname]
                                    } else {
                                        sitem.value = this.applicantData[keyname]
                                    }
                                } else if (sitem.columnId === '' && sitem.column !== keyname) {
                                    if (sitem.type === 'Attachment') {
                                        const val = sitem.value
                                        sitem.value = val
                                    } else if (sitem.type !== 'DocumentID' && sitem.type !== 'Date') {
                                        sitem.value = sitem.value_en
                                    }
                                } else if (sitem.columnId !== '' && sitem.columnBn === sitem.column && sitem.columnBn === keyname) {
                                    const laydata = this.layoutData.find(i => i.id === parseInt(sitem.columnId))
                                    const data = JSON.parse(laydata.data)
                                    if (data.field_type === 'paymentCheckbox') {
                                        const options = data.dropdownData.dropdown_options.map((item) => {
                                            if (this.$i18n.locale === 'bn') {
                                                return item.type_name_bn
                                            } else {
                                                return item.type_name
                                            }
                                        })
                                        const datas = []
                                        options.forEach((item, index) => {
                                            JSON.parse(this.applicantData[keyname]).forEach(tmp => {
                                                if (index === tmp) {
                                                datas.push(item)
                                                }
                                            })
                                        })
                                        const value = datas.join(', ')
                                        sitem.value = value
                                    } else if (data.field_type === 'payment') {
                                        const options = data.dropdownData.dropdown_options.map((item) => {
                                            if (this.$i18n.locale === 'bn') {
                                                return item.type_name_bn
                                            } else {
                                                return item.type_name
                                            }
                                        })
                                        const datas = options.filter((item, index) => index === parseInt(this.applicantData[keyname]))
                                        const value = datas.join(', ')
                                        sitem.value = value
                                    } else if (data.field_type === 'number') {
                                        sitem.value_en = this.applicantData[keyname]
                                        sitem.value_bn = this.$n(this.applicantData[keyname], { useGrouping: false })
                                        sitem.value = sitem.value_en
                                    } else if (data.field_type === 'dropdown') {
                                        if (data.dropdownData.component_id === '0') {
                                            const dropDowns = data.dropdownData.dropdown_options
                                            const drpValue = dropDowns[this.applicantData[keyname]]
                                            if (this.$i18n.locale === 'bn') {
                                                sitem.value = drpValue.name_bn
                                            } else {
                                                sitem.value = drpValue.name_bn
                                            }
                                        } else if (data.dropdownData.component_id === '1') {
                                            const drpvalue = this.getCommonStoreData(data.dropdownData.dropdown_name, this.applicantData[keyname])
                                            sitem.value = drpvalue
                                        } else {
                                            sitem.value = this.applicantData[keyname]
                                        }
                                    } else {
                                        sitem.value = this.applicantData[keyname]
                                    }
                                }
                            } else if (this.$i18n.locale === 'bn') {
                                if (sitem.columnBId !== '' && sitem.columnBn === keyname && sitem.column !== keyname) {
                                    const laydata = this.layoutData.find(i => i.id === parseInt(sitem.columnBId))
                                    const data = JSON.parse(laydata.data)
                                    if (data.field_type === 'dropdown') {
                                        if (data.dropdownData.component_id === '0') {
                                            const dropDowns = data.dropdownData.dropdown_options
                                            const drpValue = dropDowns[this.applicantData[keyname]]
                                            if (this.$i18n.locale === 'bn') {
                                                sitem.value = drpValue.name_bn
                                            } else {
                                                sitem.value = drpValue.name_bn
                                            }
                                        } else if (data.dropdownData.component_id === '1') {
                                            const drpvalue = this.getCommonStoreData(data.dropdownData.dropdown_name, this.applicantData[keyname])
                                            sitem.value = drpvalue
                                        } else {
                                            sitem.value = this.applicantData[keyname]
                                        }
                                    } else {
                                        sitem.value = this.applicantData[keyname]
                                    }
                                } else if (sitem.columnId === '' && sitem.columnBn === keyname) {
                                    if (keyname === 'generate_id') {
                                        const prefix = this.$store.state.ExternalUserService.dealerPanel.commonObj.autoGenNumTypeList.find(item => item.service_name_id === this.applicantData.service_id)
                                        sitem.value = prefix.prefix + ' - ' + this.$n(this.applicantData[keyname])
                                    } else {
                                        sitem.value = this.applicantData[keyname]
                                    }
                                } else if (sitem.columnId === '' && sitem.columnBn !== keyname) {
                                    if (sitem.type === 'Attachment') {
                                        const val = sitem.value
                                        sitem.value = val
                                    } else if (sitem.type === 'Date' && keyname === 'issue_date') {
                                        sitem.value = this.applicantData[keyname]
                                    } else if (sitem.type === 'Date' && keyname === 'expire_date') {
                                        sitem.value = this.applicantData[keyname]
                                    } else if (sitem.type !== 'DocumentID' && sitem.type !== 'Date') {
                                        sitem.value = sitem.value_bn
                                    }
                                } else if (sitem.columnId !== '' && sitem.columnBn === sitem.column && sitem.columnBn === keyname) {
                                    const laydata = this.layoutData.find(i => i.id === parseInt(sitem.columnId))
                                    const data = JSON.parse(laydata.data)
                                    if (data.field_type === 'paymentCheckbox') {
                                        const options = data.dropdownData.dropdown_options.map((item) => {
                                            if (this.$i18n.locale === 'bn') {
                                                return item.type_name_bn
                                            } else {
                                                return item.type_name
                                            }
                                        })
                                        const datas = []
                                        options.forEach((item, index) => {
                                            JSON.parse(this.applicantData[keyname]).forEach(tmp => {
                                                if (index === tmp) {
                                                datas.push(item)
                                                }
                                            })
                                        })
                                        const value = datas.join(', ')
                                        sitem.value = value
                                    } else if (data.field_type === 'payment') {
                                        const options = data.dropdownData.dropdown_options.map((item) => {
                                            if (this.$i18n.locale === 'bn') {
                                                return item.type_name_bn
                                            } else {
                                                return item.type_name
                                            }
                                        })
                                        const datas = options.filter((item, index) => index === parseInt(this.applicantData[keyname]))
                                        const value = datas.join(', ')
                                        sitem.value = value
                                    } else if (data.field_type === 'number') {
                                        sitem.value_en = this.applicantData[keyname]
                                        sitem.value_bn = this.$n(this.applicantData[keyname], { useGrouping: false })
                                        sitem.value = sitem.value_bn
                                    } else if (data.field_type === 'dropdown') {
                                        if (data.dropdownData.component_id === '0') {
                                            const dropDowns = data.dropdownData.dropdown_options
                                            const drpValue = dropDowns[this.applicantData[keyname]]
                                            if (this.$i18n.locale === 'bn') {
                                                sitem.value = drpValue.name_bn
                                            } else {
                                                sitem.value = drpValue.name_bn
                                            }
                                        } else if (data.dropdownData.component_id === '1') {
                                            const drpvalue = this.getCommonStoreData(data.dropdownData.dropdown_name, this.applicantData[keyname])
                                            sitem.value = drpvalue
                                        } else {
                                            sitem.value = this.applicantData[keyname]
                                        }
                                    } else {
                                        sitem.value = this.applicantData[keyname]
                                    }
                                }
                            }
                        })
                    })
                }
            })
        }
    }
}
</script>
<style scoped>
    .center {
        display: block !important;
        margin: auto !important;
        text-align: center !important;
        position: absolute !important;
    }
    .left {
        display: block !important;
        margin: auto !important;
        text-align: left !important;
        position: absolute !important;
    }
    .right {
        display: block !important;
        margin: auto !important;
        text-align: right !important;
        position: absolute !important;
    }
</style>
