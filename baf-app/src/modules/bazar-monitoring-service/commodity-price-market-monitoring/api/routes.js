// Master Price Category Api
const priceCategory = '/configuration/price-category/'
export const priceCategoryList = priceCategory + 'list'
export const priceCategoryStore = priceCategory + 'store'
export const priceCategoryUpdate = priceCategory + 'update'
export const priceCategoryToggle = priceCategory + 'toggle-status'
// Market Inspection Report Api
const marketInspectionReport = '/commodity-price-market-monitoring/market-inspection-report/'
export const marketInspectionReportList = marketInspectionReport + 'list'
export const marketInspectionReportStore = marketInspectionReport + 'store'
export const marketInspectionReportUpdate = marketInspectionReport + 'update'
export const marketInspectionReportToggle = marketInspectionReport + 'toggle-status'
export const marketInspectionPdf = marketInspectionReport + 'pdf-details'
export const userListByDesignWise = '/user-management/user/list-by-designation'
// Accused Person Information Api
const accusedPersonInfoBaseUrl = '/commodity-price-market-monitoring/accused-person-infos/'
export const accusedPersonInfoList = accusedPersonInfoBaseUrl + 'list'
export const accusedPersonInfoStore = accusedPersonInfoBaseUrl + 'store'
export const accusedPersonInfoUpdate = accusedPersonInfoBaseUrl + 'update'
export const accusedPersonInfoCaseNumber = accusedPersonInfoBaseUrl + 'case-number'
// price publish api routes...
export const priceUnpublishList = '/commodity-price-market-monitoring/price-publish/unpublish-list'
export const pricePublishUpdate = '/commodity-price-market-monitoring/price-publish/publish-status'

// market Directory Category api routes......
const marketDirectory = '/configuration/market-direactories/'
export const marketDirectoryCategory = marketDirectory + 'category'
// Fine Details Api
const fineDetailsBaseUrl = '/commodity-price-market-monitoring/fine-details/'
export const fineDetailsStore = fineDetailsBaseUrl + 'store'
export const fineDetailsUpdate = fineDetailsBaseUrl + 'update'

// Price Entry api routes......
const priceEntry = '/commodity-price-market-monitoring/price-entry/'
export const priceEntryStore = priceEntry + 'store'
export const priceEntryList = priceEntry + 'list'
export const pricepriceSearch = priceEntry + 'price-search'
export const priceEntryTogle = priceEntry + 'toggle-status'

// price Trend
export const priceTrendList = '/commodity-price-market-monitoring/price-trend/list'
export const marketComparisonGraph = '/commodity-price-market-monitoring/price-trend/price-comparison'
export const groupCategory = '/configuration/commodity-group/all-data/'

// daily price chart
export const dailyPriceChartList = '/commodity-price-market-monitoring/daily-price-chart/list'
