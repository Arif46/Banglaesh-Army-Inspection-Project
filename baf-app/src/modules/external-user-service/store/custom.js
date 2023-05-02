const cipAppTypeList = [
    {
        value: 1,
        text_en: 'Single',
        text_bn: 'একক'
    },
    {
        value: 2,
        text_en: 'Group',
        text_bn: 'গ্রুপ'
    }
]
const latentExporterList = [
    {
        value: 1,
        text_en: 'Yes',
        text_bn: 'হ্যাঁ'
    },
    {
        value: 2,
        text_en: 'No',
        text_bn: 'না'
    },
    {
        value: 3,
        text_en: 'Partial',
        text_bn: 'আংশিক'
    }
]
const orgTypeList = [
    {
        value: 1,
        text_en: 'Private Ltd',
        text_bn: 'প্রাইভেট লিমিটেড'
    },
    {
        value: 2,
        text_en: 'Public Ltd',
        text_bn: 'পাবলিক লিমিটেড'
    },
    {
        value: 3,
        text_en: 'Privately Owned',
        text_bn: 'ব্যক্তিগত মালিকানাধীন'
    }
]
const merchandisingTypeList = [
    {
        value: 1,
        text_en: 'Textile Factory',
        text_bn: 'টেক্সটাইল ফ্যাক্টরি'
    },
    {
        value: 2,
        text_en: 'Others',
        text_bn: 'অন্যান্য'
    }
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
        text_bn: 'জামানত ফি',
        amount: 30000,
        step_id: 4
    },
    {
        value: 3,
        text_en: 'License Fee',
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
const sellerTypeList = [
    { value: 1, text_en: 'Temporary', text_bn: 'সাময়িক' },
    { value: 2, text_en: 'Permanent', text_bn: 'স্থায়ী' }
  ]
  const applicationTypeList = [
    { value: 1, text_en: 'New', text_bn: 'নতুন' },
    { value: 2, text_en: 'Renew', text_bn: 'নবায়ন' },
    { value: 3, text_en: 'Old', text_bn: 'পুরাতন' }
  ]
  const tcbStepList = [
    { value: 0, text_en: 'Application List', text_bn: 'আবেদনের তালিকা' },
    { value: 1, text_en: 'Document Verification', text_bn: 'ডকুমেন্ট ভেরিফিকেশন' },
    { value: 2, text_en: 'Inspection', text_bn: 'পরিদর্শন' },
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
  const factoryApplicationApplicantType = [
    {
      value: 1,
      text: 'Person',
      text_en: 'Person',
      text_bn: 'ব্যাক্তিক'
    },
    {
      value: 2,
      text: 'Limited Company',
      text_en: 'Limited Company',
      text_bn: 'লিমিটেড কোম্পানি'
    },
    {
      value: 3,
      text: 'Partnership Business',
      text_en: 'Partnership Business',
      text_bn: 'অংশীদারি ব্যবসা'
    },
    {
      value: 4,
      text: 'Cooperative Society',
      text_en: 'Cooperative Society',
      text_bn: 'সমবায় সমিতি'
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
  const portTypeList = [
    {
      value: 1,
      text: 'Land port',
      text_en: 'Land port',
      text_bn: 'স্থলবন্দর'
    },
    {
      value: 2,
      text: 'Sea port',
      text_en: 'Sea port',
      text_bn: 'সমুদ্র বন্দর'
    },
    {
      value: 3,
      text: 'Airport',
      text_en: 'Airport',
      text_bn: 'বিমানবন্দর'
    }
  ]
  const productTypeList = [
    {
      value: 1,
      text: 'Agriculture',
      text_en: 'Agriculture',
      text_bn: 'কৃষি'
    },
    {
      value: 2,
      text: 'Industrial',
      text_en: 'Industrial',
      text_bn: 'শিল্প'
    }
  ]

export default {
    cipAppTypeList,
    latentExporterList,
    orgTypeList,
    merchandisingTypeList,
    paymentTypeList,
    sellerTypeList,
    applicationTypeList,
    tcbStepList,
    maritalStatusList,
    actionTypeList,
    factoryApplicationApplicantType,
    stallTypeList,
    portTypeList,
    productTypeList
}
