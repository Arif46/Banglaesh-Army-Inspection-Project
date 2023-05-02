// productServiceTypeList List
const productServiceTypeList = [
    { value: 1, text_en: 'Product', text_bn: 'পণ্য' },
    { value: 2, text_en: 'Service', text_bn: 'সেবা' }
]

const assignTypeList = [
    { value: 1, text_en: 'CIP', text_bn: 'সিআইপি' },
    { value: 2, text_en: 'Export Trophy', text_bn: 'রপ্তানি ট্রফি' }
    // { value: 3, text_en: 'All', text_bn: 'সব' }
]

const applicationTypeList = [
    { value: 1, text_en: 'CIP Application', text_bn: 'সিআইপি আবেদন' },
    { value: 2, text_en: 'Export Trophy Application', text_bn: 'রপ্তানি ট্রফি আবেদন' }
]

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

export default {
    productServiceTypeList,
    assignTypeList,
    applicationTypeList,
    cipAppTypeList,
    latentExporterList,
    orgTypeList,
    merchandisingTypeList
}
