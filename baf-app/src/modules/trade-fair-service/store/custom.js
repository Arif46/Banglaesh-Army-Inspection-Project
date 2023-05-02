const committeeTypeList = [
  {
    value: 1,
    text: 'Mela Division',
    text_en: 'Mela Division',
    text_bn: 'মেলা বিভাগ'
  },
  {
    value: 2,
    text: 'DITF',
    text_en: 'DITF',
    text_bn: 'ডিআইটিএফ'
  }
]

const stallTypeList = [
  {
    value: 1,
    text: 'Corner',
    text_en: 'Corner',
    text_bn: 'কর্ণার '
  },
  {
    value: 2,
    text: 'Regular',
    text_en: 'Regular',
    text_bn: 'রেগুলার '
  }
]

const typeOfFair = [
  { text_en: 'Sourcing', text_bn: 'সোর্সিং', value: 1 },
  { text_en: 'Consumer', text_bn: 'ভোক্তা', value: 2 }
]

const paymentStatusList = [
  { text_en: 'Paid', text_bn: 'পেইড', value: 1 },
  { text_en: 'Refund', text_bn: 'রিফান্ড', value: 2 }
]

const companyTypeList = [
  { value: 1, text: 'Limited', text_en: 'Limited', text_bn: 'লিমিটেড' },
  { value: 2, text: 'Partnership', text_en: 'Partnership', text_bn: 'অংশীদারিত্ব' },
  { value: 3, text: 'Proprietorship', text_en: 'Proprietorship', text_bn: 'স্বত্ব' },
  { value: 4, text: 'Others', text_en: 'Others', text_bn: 'অন্যান্য' }
]

const companyNatureList = [
  { value: 1, text: 'Manufacture', text_en: 'Manufacture', text_bn: 'উৎপাদন' },
  { value: 2, text: 'Manufacturer cum Exporter', text_en: 'Manufacturer cum Exporter', text_bn: 'প্রস্তুতকারক এবং রপ্তানিকারক' },
  { value: 3, text: 'Exporter', text_en: 'Exporter', text_bn: 'রপ্তানিকারক' },
  { value: 4, text: 'Trader', text_en: 'Trader', text_bn: 'ব্যবসায়ী' },
  { value: 5, text: 'Others', text_en: 'Others', text_bn: 'অন্যান্য' }
]

// Ditf Custom Dropdown
const circularTypeList = [
  { value: 1, text: 'Pavilion', text_en: 'Pavilion', text_bn: 'প্যাভিলিয়ন' },
  { value: 2, text: 'Others', text_en: 'Others', text_bn: 'অন্যান্য' }
]

const countryTypeList = [
  { value: 1, text: 'Local', text_en: 'Local', text_bn: 'স্থানীয়' },
  { value: 2, text: 'Foreign', text_en: 'Foreign', text_bn: 'বিদেশী' }
]

const ditfStallTypeList = [
  { value: 1, text: 'Local', text_en: 'Local', text_bn: 'স্থানীয়' },
  { value: 2, text: 'Foreign', text_en: 'Foreign', text_bn: 'বিদেশী' }
]

const priceTypeList = [
  { value: 1, text: 'Fixed', text_en: 'Fixed', text_bn: 'সুনির্দিষ্ট' },
  { value: 2, text: 'Bidding', text_en: 'Bidding', text_bn: 'নীলামে ডাক' }
]

export default {
  committeeTypeList,
  stallTypeList,
  typeOfFair,
  paymentStatusList,
  companyTypeList,
  companyNatureList,
  circularTypeList,
  countryTypeList,
  ditfStallTypeList,
  priceTypeList
}
