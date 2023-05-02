const inspectByList = [
  {
    value: 1,
    text: 'Executive Magistrate',
    text_en: 'Executive Magistrate',
    text_bn: 'নির্বাহী ম্যাজিস্ট্রেট'
  },
  {
    value: 2,
    text: 'DNCRP Representative',
    text_en: 'DNCRP Representative',
    text_bn: 'ডিএনসিআরপি প্রতিনিধি'
  }
]
const zoneList = [
  {
    value: 1,
    text: 'Chittagong',
    text_en: 'Chittagong',
    text_bn: 'চট্টগ্রাম'
  },
  {
    value: 2,
    text: 'Sreemangal',
    text_en: 'Sreemangal',
    text_bn: 'শ্রীমঙ্গল'
  }
]
const frequencyTypeList = [
  {
    value: 1,
    text: 'Daily',
    text_en: 'Daily',
    text_bn: 'দৈনিক'
  },
  {
    value: 2,
    text: 'Weekly',
    text_en: 'Weekly',
    text_bn: 'সাপ্তাহিক'
  },
  {
    value: 3,
    text: 'Monthly',
    text_en: 'Monthly',
    text_bn: 'মাসিক'
  },
  {
    value: 4,
    text: 'Yearly',
    text_en: 'Yearly',
    text_bn: 'বার্ষিক'
  }
]
function generateYearList () {
  const min = new Date().getFullYear()
  const oldMax = min - 50
  const newMax = min
  const newYears = []
  const oldYears = []
  for (let i = oldMax; i < min; i++) {
      oldYears.push(i)
  }
  for (let j = min; j <= newMax; j++) {
      newYears.push(j)
  }
  const yearList = [...oldYears, ...newYears]
  return yearList
}
const yearList = generateYearList()
// year list for scholarship & season amount distribution
function generateSeasonYearList () {
  const min = new Date().getFullYear()
  const oldMax = min - 2
  const newMax = min + 2
  const newYears = []
  const oldYears = []
  for (let i = oldMax; i < min; i++) {
      oldYears.push(i)
  }
  for (let j = min; j <= newMax; j++) {
      newYears.push(j)
  }
  const yearList = [...oldYears, ...newYears]
  return yearList
}
const seasonYearList = generateSeasonYearList()
const trustType = [
  {
    value: 1,
    text: 'Primary',
    text_en: 'Primary',
    text_bn: 'প্রাথমিক'
  },
  {
    value: 2,
    text: 'Secondary',
    text_en: 'Secondary',
    text_bn: 'মাধ্যমিক'
  }
]
const gardenType = [
  {
    value: 1,
    text: 'Tea Estate',
    text_en: 'Tea Estate',
    text_bn: 'চা এস্টেট'
  },
  {
    value: 2,
    text: 'Tea Garden',
    text_en: 'Tea Garden',
    text_bn: 'চা বাগান'
  },
  {
    value: 3,
    text: 'Small Tea Garden',
    text_en: 'Small Tea Garden',
    text_bn: 'ছোট চা বাগান'
  }
]
const workerType = [
  {
    value: 1,
    text: 'Registered',
    text_en: 'Registered',
    text_bn: 'নিবন্ধিত'
  },
  {
    value: 2,
    text: 'Unregistered',
    text_en: 'Unregistered',
    text_bn: 'অনিবন্ধিত'
  }
]
const gender = [
  {
    value: 1,
    text: 'Male',
    text_en: 'Male',
    text_bn: 'পুরুষ'
  },
  {
    value: 2,
    text: 'Female',
    text_en: 'Female',
    text_bn: 'মহিলা'
  },
  {
    value: 3,
    text: 'Other',
    text_en: 'Other',
    text_bn: 'অন্যান্য'
  }
]
const schoolLocation = [
  {
    value: 1,
    text: 'Inside',
    text_en: 'Inside',
    text_bn: 'ভিতরে'
  },
  {
    value: 2,
    text: 'Outside',
    text_en: 'Outside',
    text_bn: 'বাইরে'
  }
]
const schoolStatus = [
  {
    value: 1,
    text: 'Raw',
    text_en: 'Raw',
    text_bn: 'কাঁচা'
  },
  {
    value: 2,
    text: 'Semi Building',
    text_en: 'Semi Building',
    text_bn: 'সেমি বিল্ডিং'
  },
  {
    value: 3,
    text: 'Building',
    text_en: 'Building',
    text_bn: 'বিল্ডিং'
  }
]
const schoolCategory = [
  {
    value: 1,
    text: 'Government',
    text_en: 'Government',
    text_bn: 'সরকারী'
  },
  {
    value: 2,
    text: 'NGO',
    text_en: 'NGO',
    text_bn: 'এনজিও'
  },
  {
    value: 3,
    text: 'MPO/ Registered',
    text_en: 'MPO/ Registered',
    text_bn: 'এমপিও/ নিবন্ধিত'
  },
  {
    value: 4,
    text: 'Garden',
    text_en: 'Garden',
    text_bn: 'বাগান'
  }
]
const forestResource = [
  {
    value: 1,
    text: 'Shed Tree',
    text_en: 'Shed Tree',
    text_bn: 'শেড গাছ'
  },
  {
    value: 2,
    text: 'Planted Tree',
    text_en: 'Planted Tree',
    text_bn: 'লাগানো গাছ'
  },
  {
    value: 3,
    text: 'Natural Tree',
    text_en: 'Natural Tree',
    text_bn: 'প্রাকৃতিক গাছ'
  },
  {
    value: 4,
    text: 'Rubber',
    text_en: 'Rubber',
    text_bn: 'রাবার'
  },
  {
    value: 5,
    text: 'Bamboo',
    text_en: 'Bamboo',
    text_bn: 'বাঁশ'
  },
  {
    value: 6,
    text: 'Others',
    text_en: 'Others',
    text_bn: 'অন্যান্য'
  }
]
const purposeTreeFelling = [
  {
    value: 1,
    text: 'Tea Cultivation Extension',
    text_en: 'Tea Cultivation Extension',
    text_bn: 'চা চাষ সম্প্রসারণ'
  },
  {
    value: 2,
    text: 'Re-Plantation',
    text_en: 'Re-Plantation',
    text_bn: 'পুনরায় বৃক্ষরোপণ'
  },
  {
    value: 3,
    text: 'Very Old Tree',
    text_en: 'Very Old Tree',
    text_bn: 'খুব পুরানো গাছ'
  },
  {
    value: 4,
    text: 'Planted Rubber',
    text_en: 'Planted Rubber',
    text_bn: 'রোপণ করা রাবার'
  },
  {
    value: 5,
    text: 'Diseased Tree',
    text_en: 'Diseased Tree',
    text_bn: 'রোগাক্রান্ত গাছ'
  },
  {
    value: 6,
    text: 'Others',
    text_en: 'Others',
    text_bn: 'অন্যান্য'
  }
]
const unitQuantity = [
  {
    value: 1,
    text: 'Cubic Feet',
    text_en: 'Cubic Feet',
    text_bn: 'ঘনফুট'
  },
  {
    value: 2,
    text: 'Cubic Meter',
    text_en: 'Cubic Meter',
    text_bn: 'ঘন মিটার'
  }
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
const organicFertilizerTypes = [
  {
    value: 1,
    text: 'Manure/organic manure',
    text_en: 'Manure/organic manure',
    text_bn: 'সার/জৈব সার'
  },
  {
    value: 2,
    text: 'Compost',
    text_en: 'Compost',
    text_bn: 'কম্পোস্ট'
  },
  {
    value: 3,
    text: 'Vermicompost',
    text_en: 'Vermicompost',
    text_bn: 'ভার্মিকম্পোস্ট'
  },
  {
    value: 4,
    text: 'Tricho Compost',
    text_en: 'Tricho Compost',
    text_bn: 'ট্রাইকো কম্পোস্ট'
  }
]
const soilTestType = [
  {
    value: 1,
    text: 'Garden Demand',
    text_en: 'Garden Demand',
    text_bn: 'বাগানের চাহিদা'
  },
  {
    value: 2,
    text: 'Advisory Test',
    text_en: 'Advisory Test',
    text_bn: 'পরামর্শমূলক প্রতিবেদন'
  }
]
const btriPaymentType = [
  {
    value: 1,
    text: 'Cash',
    text_en: 'Cash',
    text_bn: 'ক্যাশ'
  },
  {
    value: 2,
    text: 'Bank',
    text_en: 'Bank',
    text_bn: 'ব্যাংক'
  },
  {
    value: 3,
    text: 'ekPay',
    text_en: 'ekPay',
    text_bn: 'একপে'
  }
]
const teaSmapleTestType = [
  {
    value: 1,
    text: 'Organoleptic',
    text_en: 'Organoleptic',
    text_bn: 'অর্গানলেপটিক'
  },
  {
    value: 2,
    text: 'Lab Test',
    text_en: 'Lab Test',
    text_bn: 'ল্যাব টেস্ট'
  }
]
export default {
  inspectByList,
  frequencyTypeList,
  trustType,
  yearList,
  zoneList,
  gardenType,
  workerType,
  gender,
  schoolLocation,
  schoolStatus,
  schoolCategory,
  seasonYearList,
  forestResource,
  purposeTreeFelling,
  unitQuantity,
  factoryApplicationApplicantType,
  organicFertilizerTypes,
  soilTestType,
  btriPaymentType,
  teaSmapleTestType
}
