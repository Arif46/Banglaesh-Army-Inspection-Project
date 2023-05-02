const inputOptionList = [
    { item: 'text', text_en: 'Text', text_bn: 'টেক্সট' },
    { item: 'email', text_en: 'Email', text_bn: 'ইমেইল' },
    { item: 'number', text_en: 'Number', text_bn: 'নম্বর' },
    { item: 'dropdown', text_en: 'Dropdown', text_bn: 'ড্রপডাউন' },
    { item: 'image', text_en: 'Image', text_bn: 'ছবি' }
  ]
const operatorList = [
  { text: '+', value: '+' },
  { text: '-', value: '-' },
  { text: 'x', value: 'x' },
  { text: '/', value: '/' }
]
const alignmentList = [
  { value: 1, text_en: 'Left', text_bn: 'বাম' },
  { value: 2, text_en: 'Right', text_bn: 'ডান' },
  { value: 3, text_en: 'Top', text_bn: 'উপর' },
  { value: 4, text_en: 'Bottom', text_bn: 'নীচে' },
  { value: 5, text_en: 'Center', text_bn: 'কেন্দ্র' }
]

const tmpLanguageTypeList = [
  { value: 'en', text_en: 'English', text_bn: 'ইংরেজি' },
  { value: 'bn', text_en: 'Bangla', text_bn: 'বাংলা' }
]

const sellerTypeList = [
  { value: 1, text_en: 'Temporary', text_bn: 'সাময়িক' },
  { value: 2, text_en: 'Permanent', text_bn: 'স্থায়ী' }
]

const distanceList = [
  { value: 1, text_en: '0 - 50', text_bn: '০ - ৫০' },
  { value: 2, text_en: '51 - 100', text_bn: '৫১ - ১০০' },
  { value: 3, text_en: '101 - Upper', text_bn: '১০১ - উপরে' }
]

const applicationTypeList = [
  { value: 1, text_en: 'New', text_bn: 'নতুন' },
  { value: 2, text_en: 'Renew', text_bn: 'নবায়ন' },
  { value: 3, text_en: 'Old', text_bn: 'পুরাতন' }
]

const tcbStepList = [
  { value: 0, text_en: 'Application List', text_bn: 'আবেদনের তালিকা' },
  { value: 1, text_en: 'Document Verification', text_bn: 'ডকুমেন্ট ভেরিফিকেশন' },
  { value: 2, text_en: 'Inspection And Recommendation', text_bn: 'পরিদর্শন ও সুপারিশ' },
  { value: 3, text_en: 'Approval', text_bn: 'অনুমোদন' },
  { value: 4, text_en: 'Agrement', text_bn: 'চুক্তি' },
  { value: 5, text_en: 'Archive', text_bn: 'আর্কাইভ' }
]

const maritalStatusList = [
  { text_en: 'Married', text_bn: 'বিবাহিত', value: 1 },
  { text_en: 'Unmarried', text_bn: 'অবিবাহিত', value: 2 }
]

const actionTypeList = [
    { text_en: 'Resubmit', text_bn: 'রি-সাবমিট', value: 3 },
    { text_en: 'Reject', text_bn: 'প্রত্যাখ্যান', value: 2 }
]
const paymentTypeList = [
  {
      value: 1,
      text_en: 'Registration Fee',
      text_bn: 'আবেদন ফি',
      amount: 5000,
      step_id: 0
  },
  {
      value: 2,
      text_en: 'Security Money',
      text_bn: 'নিরাপত্তার ফি',
      amount: 30000,
      step_id: 4
  },
  {
      value: 3,
      text_en: 'License',
      text_bn: 'লাইসেন্স ফি',
      amount: 10000,
      step_id: 4
  },
  {
      value: 4,
      text_en: 'Renewal Fee',
      text_bn: 'নবায়ন ফি',
      amount: 10000,
      step_id: 0
  },
  {
      value: 5,
      text_en: 'Late Fee',
      text_bn: 'বিলম্ব ফি',
      amount: 1000,
      step_id: 0
  },
  {
    value: 6,
    text_en: 'Allocation Fee',
    text_bn: 'বরাদ্দ ফি',
    amount: 0,
    step_id: 5
  }
]
const adminPaymentTypeList = [
  {
      value: 1,
      text_en: 'Registration Fee',
      text_bn: 'আবেদন ফি',
      amount: 5000,
      step_id: 0
  },
  {
      value: 2,
      text_en: 'Security Money',
      text_bn: 'নিরাপত্তার ফি',
      amount: 30000,
      step_id: 4
  },
  {
      value: 3,
      text_en: 'License',
      text_bn: 'লাইসেন্স ফি',
      amount: 10000,
      step_id: 4
  }
]
export default {
  inputOptionList,
  operatorList,
  alignmentList,
  tmpLanguageTypeList,
  sellerTypeList,
  distanceList,
  applicationTypeList,
  tcbStepList,
  maritalStatusList,
  paymentTypeList,
  actionTypeList,
  adminPaymentTypeList
}
