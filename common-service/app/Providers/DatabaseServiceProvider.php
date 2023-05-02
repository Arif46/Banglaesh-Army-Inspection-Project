<?php

namespace App\Providers;
use Illuminate\Support\Facades\{Auth, Cache, DB, Redis};
use Illuminate\Support\ServiceProvider;

class DatabaseServiceProvider extends ServiceProvider
{

    protected $defer = true;
    /**
     * Register services.
     *
     * @return void
     */

    public function register()
    {
        /*-----CommitteeList-----*/
        $this->app->singleton('committeeList', function ($app) {
            return Cache::store('redis')->rememberForever('committee', function () {
                return DB::table('cmt_committees')
                    ->select('id as value','committee_name as text','committee_name as text_en',
                        'committee_name_bn as text_bn','org_id','status')
                    ->orderBy('committee_name', 'asc')
                    ->get();
            });
        });

        /*-----CommitteeList-----*/
        $this->app->singleton('agendaList', function ($app) {
            return Cache::store('redis')->rememberForever('agenda', function () {
                return DB::table('cmt_agenda')
                    ->select('id as value','agenda_name as text','agenda_name as text_en',
                        'agenda_name_bn as text_bn','org_id', 'cmt_committee_id', 'status')
                    ->orderBy('agenda_name', 'asc')
                    ->get();
            });
        });

        /*-----Post Data-----*/
        $this->app->singleton('componentList', function ($app) {
            return Cache::store('redis')->rememberForever('components', function () {
                return DB::table('master_components')
                    ->select('id as value','component_name as text','component_name as text_en',
                        'component_name_bn as text_bn','sorting_order','status')
                    ->orderBy('component_name', 'asc')
                    ->get();
            });
        });
        /* ------------- orgComponentList------------ */
        $this->app->singleton('orgComponentList', function ($app) {
            return Cache::store('redis')->rememberForever('orgComponents', function () {
                return DB::table('master_org_components')
                ->select('org_id', 'component_id')
                ->get();
            });
        });
        /*---------------moduleList--------*/
        $this->app->singleton('moduleList', function ($app) {
            return Cache::store('redis')->rememberForever('module', function () {
                return DB::table('master_modules')
                    ->select('id as value','component_id','module_name as text','module_name as text_en',
                        'module_name_bn as text_bn','sorting_order','status')
                    ->orderBy('module_name', 'asc')
                    ->get();
            });
        });

        $this->app->singleton('serviceList', function ($app) {
            return Cache::store('redis')->rememberForever('service', function () {
                return DB::table('master_services')
                    ->select('id as value','service_name as text','service_name as text_en','component_id','module_id',
                        'service_name_bn as text_bn','sorting_order', 'status')
                    ->orderBy('service_name', 'asc')
                    ->get();
            });
        });

        /*---------------DivisionListCommonDropdownsServiceRegister--------*/
        $this->app->singleton('divisionList', function ($app) {
            return Cache::store('redis')->rememberForever('divisions', function () {
                return DB::table('master_divisions')
                    ->select('id as value','division_name as text','division_name as text_en',
                        'division_name_bn as text_bn','country_id', 'division_code', 'status')
                    ->orderBy('division_name', 'asc')
                    ->get();
            });
        });

        /*---------------CountryListCommonDropdownsServiceRegister--------*/
        $this->app->singleton('countryList', function ($app) {
            return Cache::store('redis')->rememberForever('countries', function () {
                return DB::table('master_countries')
                    ->select('id as value','country_name as text','country_name as text_en',
                        'country_name_bn as text_bn', 'nationality', 'nationality_bn', 'country_code', 'status')
                    ->orderBy('country_name', 'asc')
                    ->get();
            });
        });

         /*---------------dialogueInfosListCommonDropdownsServiceRegister--------*/
         $this->app->singleton('dialogueInfosList', function ($app) {
            return Cache::store('redis')->rememberForever('dialogueInfos', function () {
                return DB::table('master_dialogue_settings')
                    ->select('id as value','dialogue as text','dialogue as text_en',
                        'dialogue_bn as text_bn', 'position', 'status')
                        ->orderBy('dialogue', 'asc')
                        ->get();
            });
        });
        /*---------------DistrictListCommonDropdownsServiceRegister--------*/
        $this->app->singleton('districtList', function ($app) {
            return Cache::store('redis')->rememberForever('districts', function () {
                return DB::table('master_districts')
                    ->select('id as value','district_name as text','district_name as text_en',
                        'district_name_bn as text_bn', 'division_id', 'district_code', 'status')
                    ->orderBy('district_name', 'asc')
                    ->get();
            });
        });
        /*---------------UpazilaListCommonDropdownsServiceRegister--------*/
        $this->app->singleton('upazilaList', function ($app) {
            return Cache::store('redis')->rememberForever('upazilas', function () {
                return DB::table('master_upazilas')
                    ->select('id as value','upazila_name as text','upazila_name as text_en',
                        'upazila_name_bn as text_bn', 'district_id', 'upazila_code', 'status')
                    ->orderBy('upazila_name', 'asc')
                    ->get();
            });
        });
        /*---------------Thana List CommonDropdownsService Register--------*/
        $this->app->singleton('thanaList', function ($app) {
            return Cache::store('redis')->rememberForever('thanas', function () {
                return DB::table('master_thanas')
                    ->select('id as value','thana_name as text','thana_name as text_en',
                        'thana_name_bn as text_bn', 'district_id', 'thana_code', 'status')
                    ->orderBy('thana_name', 'asc')
                    ->get();
            });
        });
        /*---------------UnionListCommonDropdownsServiceRegister--------*/
        $this->app->singleton('unionList', function ($app) {
            return Cache::store('redis')->rememberForever('unions', function () {
                return DB::table('master_unions')
                    ->select('id as value','union_name as text','union_name as text_en',
                        'union_name_bn as text_bn', 'division_id', 'district_id', 'upazila_id',
                        'union_code', 'status')
                    ->orderBy('union_name', 'asc')
                    ->get();
            });
        });
        /*---------------cityCorporationListCommonDropdownsServiceRegister--------*/
        $this->app->singleton('cityCorporationList', function ($app) {
            return Cache::store('redis')->rememberForever('cityCorporations', function () {
                return DB::table('master_city_corporations')
                    ->select('id as value','city_corporation_name as text','city_corporation_name as text_en',
                        'city_corporation_name_bn as text_bn', 'division_id', 'district_id', 'city_corporation_code', 'status')
                    ->orderBy('city_corporation_name', 'asc')
                    ->get();
            });
        });

        /*---------------MunicipalityListCommonDropdownsServiceRegister--------*/
        $this->app->singleton('municipalityList', function ($app) {
            return Cache::store('redis')->rememberForever('municipalities', function () {
                return DB::table('master_pauroshobas')
                    ->select('id as value','pauroshoba_name as text','pauroshoba_name as text_en',
                        'pauroshoba_name_bn as text_bn', 'division_id', 'district_id', 'upazila_id', 'status')
                    ->orderBy('pauroshoba_name', 'asc')
                    ->get();
            });
        });
        /*---------------MenuList--------*/
        $this->app->singleton('menuList', function ($app) {
            return Cache::store('redis')->rememberForever('menu', function () {
                return DB::table('master_menus')
                    ->select('id as value','menu_name as text','menu_name as text_en',
                        'menu_name_bn as text_bn','component_id', 'module_id','service_id','status')
                    ->orderBy('menu_name', 'asc')
                    ->get();
            });
        });

        /*---------------OfficeTypeList--------*/
        $this->app->singleton('officeTypeList', function ($app) {
            return Cache::store('redis')->rememberForever('officeTypes', function () {
                return DB::table('master_office_types')
                    ->select('id as value','office_type_name as text','office_type_name as text_en',
                        'office_type_name_bn as text_bn','org_id', 'status')
                    ->orderBy('office_type_name', 'asc')
                    ->get();
            });
        });
         /*---------------WardListCommonDropdownsServiceRegister--------*/
         $this->app->singleton('wardList', function ($app) {
            return Cache::store('redis')->rememberForever('wards', function () {
                return DB::table('master_ward_details')
                ->join('master_wards', 'master_ward_details.master_ward_id', '=','master_wards.id')
                ->select(
                  'master_ward_details.id as value',
                  'master_ward_details.ward_name as text',
                  'master_ward_details.ward_name as text_en',
                  'master_ward_details.ward_name_bn as text_bn',
                  'master_wards.division_id',
                  'master_wards.district_id',
                  'master_wards.city_corporation_id',
                  'master_wards.pauroshoba_id',
                  'master_wards.municipality_id',
                  'master_wards.upazila_id',
                  'master_wards.union_id',
                  'master_wards.status'
                  )
                ->addSelect(DB::raw("'union_id' as parent"))
                ->orderBy('master_ward_details.ward_name', 'asc')
                ->get();
            });
        });

        /*---------------orgProfileList--------*/
        $this->app->singleton('orgProfileList', function ($app) {
            return Cache::store('redis')->rememberForever('organizationProfileList', function () {
                return DB::table('master_org_profiles')
                    ->select(
                        'id as value',
                        'org_name as text',
                        'org_name as text_en',
                        'org_name_bn as text_bn',
                        'abbreviation',
                        'abbreviation_bn',
                        'status')
                    ->orderBy('org_name', 'asc')
                    ->get();
            });
        });

        /*---------------FiscalYear--------*/
        $this->app->singleton('fiscalYearList', function ($app) {
            return Cache::store('redis')->rememberForever('fiscalyear', function () {
                return DB::table('master_fiscal_years')
                    ->select('id as value','year as text','year as text_en', 'sorting_order',
                        'year as text_bn','start_date', 'end_date','status')
                    ->orderBy('start_date', 'asc')
                    ->get();
            });
        });

        /*---------------bankList--------*/
        $this->app->singleton('bankList', function ($app) {
            return Cache::store('redis')->rememberForever('banks', function () {
                return DB::table('master_banks')
                    ->select('id as value','bank_name as text','bank_name as text_en',
                        'bank_name_bn as text_bn','org_id', 'component_id','status')
                    ->orderBy('bank_name', 'asc')
                    ->get();
            });
        });

        $this->app->singleton('bankNameList', function ($app) {
            return Cache::store('redis')->rememberForever('bankNames', function () {
                return DB::table('master_banks')
                    ->select('id as value','bank_name as text','bank_name as text_en',
                        'bank_name_bn as text_bn', 'status')
                    ->orderBy('bank_name', 'asc')
                    ->get();
            });
        });

        /*---------------branchList--------*/
        $this->app->singleton('branchList', function ($app) {
            return Cache::store('redis')->rememberForever('branch', function () {
                return DB::table('master_branchs')
                    ->select('id as value','branch_name as text','branch_name as text_en',
                        'branch_name_bn as text_bn','org_id', 'bank_id','address','address_bn','status')
                    ->orderBy('branch_name', 'asc')
                    ->get();
            });
        });
        
        /*---------------branchNameList--------*/
        $this->app->singleton('branchNameList', function ($app) {
            return Cache::store('redis')->rememberForever('branchName', function () {
                return DB::table('master_branchs')
                    ->select('id as value','branch_name as text','branch_name as text_en',
                        'branch_name_bn as text_bn', 'bank_id','address','address_bn','status')
                    ->orderBy('branch_name', 'asc')
                    ->get();
            });
        });

        /*---------------officeList--------*/
        $this->app->singleton('officeList', function ($app) {
            return Cache::store('redis')->rememberForever('offices', function () {
                return DB::table('master_offices')
                    ->select('id as value','office_name as text','office_name as text_en',
                        'office_name_bn as text_bn','org_id', 'office_type_id', 'country_id',
                        'division_id', 'district_id', 'upazila_id', 'union_id', 'is_regional_office', 'parent_office_type_id',
                        'parent_office_id','status')
                    ->orderBy('office_name', 'asc')
                    ->get();
            });
        });

        /*---------------branchList--------*/
        $this->app->singleton('branchList', function ($app) {
            return Cache::store('redis')->rememberForever('branch', function () {
                return DB::table('master_branchs')
                    ->select('id as value','branch_name as text','branch_name as text_en',
                        'branch_name_bn as text_bn','org_id', 'bank_id','status')
                    ->orderBy('branch_name', 'asc')
                    ->get();
            });
        });

        /*---------------designationList--------*/
        $this->app->singleton('designationList', function ($app) {
            return Cache::store('redis')->rememberForever('designation', function () {
                return DB::table('master_designations')
                ->select(
                    'id as value',
                    'org_id',
                    'designation as text',
                    'designation as text_en',
                    'designation_bn as text_bn',
                    'direct_post',
                    'promotional_post',
                    'total_post',
                    'grade_id',
                    'status'
                )
                ->orderBy('designation', 'asc')
                ->get();
            });
        });

        /*---------------NotificationSetupList--------*/
        $this->app->singleton('NotificationSetupList', function ($app) {
            return Cache::store('redis')->rememberForever('NotificationSetup', function () {
                return DB::table('notification_settings')
                ->select("id as value",'component_id','module_id','service_id', 'menu_id', 'template_id','button_id','mobile_text','email_web_text','media_id','recipient_id','status')
                ->orderBy('value', 'asc')
                ->get();
            });
        });

        /*---------------notificationTypeList--------*/
           $this->app->singleton('notificationTypeList', function ($app) {
            return Cache::store('redis')->rememberForever('notificationTypes', function () {
                return DB::table('master_notification_types')
                ->select('id as value','not_type_name as text','not_type_name as text_en',
                'not_type_name_bn as text_bn', 'status')
                ->orderBy('not_type_name', 'asc')
                ->get();
            });
        });

         /*---------------NotCirculateNoticeList--------*/
         $this->app->singleton('NotCirculateNoticeList', function ($app) {
            return Cache::store('redis')->rememberForever('NotCirculateNotice', function () {
                return DB::table('not_circulate_notices')
                ->select('id as value','notice_title as text','notice_title as text_en',
                'notice_title_bn as text_bn', 'status')
                ->orderBy('notice_title', 'asc')
                ->get();
            });
        });


          /*---------------notificationTemplateList--------*/
        $this->app->singleton('notificationTemplateList', function ($app) {
            return Cache::store('redis')->rememberForever('notificationTemplates', function () {
                return DB::table('message_template')
                ->select('id as value','template as text','template as text_en','template as text_bn','mobile_text', 'email_web_text', 'status')
                ->orderBy('template', 'asc')
                ->get();
            });
        });

        /*--------------- assign designationList--------*/
        $this->app->singleton('assignDesignationList', function ($app) {
            return Cache::store('redis')->rememberForever('assignDesignation', function () {
                return DB::table('assign_designations')
                    ->join('master_designations', 'master_designations.id', '=','assign_designations.designation_id')
                    ->select(
                        'master_designations.id as value',
                        'master_designations.designation as text',
                        'master_designations.designation as text_en',
                        'master_designations.designation_bn as text_bn',
                        'assign_designations.org_id',
                        'assign_designations.office_type_id',
                        'assign_designations.office_id'
                        )
                    ->orderBy('master_designations.designation', 'asc')
                    ->get();
            });
        });

        /*--------------- document category list--------*/
        $this->app->singleton('documentCategoryList', function ($app) {
            return Cache::store('redis')->rememberForever('documentCategory', function () {
                return DB::table('master_document_categories')
                ->select('id as value','category_name as text','category_name as text_en',
                'category_name_bn as text_bn', 'status')
                ->orderBy('category_name', 'asc')
                ->get();
            });
        });

        /*--------------- portal ministry name list--------*/
        $this->app->singleton('ministryNameList', function ($app) {
            return Cache::store('redis')->rememberForever('ministryNames', function () {
                return DB::table('portal_ministry_entries')
                ->select('id as value','ministry_name as text','ministry_name as text_en',
                'ministry_name_bn as text_bn', 'status')
                ->orderBy('ministry_name', 'asc')
                ->get();
            });
        });

        /*--------------- portal ex-organization list--------*/
        $this->app->singleton('exOrgList', function ($app) {
            return Cache::store('redis')->rememberForever('exOrgNames', function () {
                return DB::table('portal_ex_organizations')
                ->select('id as value','ex_org_name as text','ex_org_name as text_en', 'ministry_id',
                'ex_org_name_bn as text_bn', 'status')
                ->orderBy('ex_org_name', 'asc')
                ->get();
            });
        });

         /*--------------- service category list--------*/
         $this->app->singleton('portalServiceCategoryList', function ($app) {
            return Cache::store('redis')->rememberForever('ServiceCategories', function () {
                return DB::table('portal_service_categories')
                ->select('id as value','name as text','name as text_en',
                'name_bn as text_bn', 'status')
                ->orderBy('name', 'asc')
                ->get();
            });
        });

        /*--------------- service name list--------*/
        $this->app->singleton('portalServiceNameList', function ($app) {
            return Cache::store('redis')->rememberForever('portalServiceName', function () {
                return DB::table('portal_services')
                ->select('id as value','name as text','name as text_en', 'name_bn as text_bn', 'component_id', 'ministry_id', 
                'ex_org_id', 'service_category_id', 'status')
                ->where('service_type_id', 1) // 1 means IDSDP
                ->orderBy('name', 'asc')
                ->get();
            });
        });
            /*--------------- service customer type list--------*/
            $this->app->singleton('portalCustomerTypeList', function ($app) {
                return Cache::store('redis')->rememberForever('CustomerTypes', function () {
                    return DB::table('portal_service_customer_types')
                    ->select('id as value','name as text','name as text_en',
                    'name_bn as text_bn', 'status')
                    ->orderBy('name', 'asc')
                    ->get();
                });
            });

        /*--------------- Document list--------*/
        $this->app->singleton('documentList', function ($app) {
            return Cache::store('redis')->rememberForever('document', function () {
                return DB::table('doc_doc_infos')
                ->select('id as value','doc_title as text','doc_title as text_en',
                'doc_title_bn as text_bn','attachment','org_id','category_id','status')
                ->orderBy('doc_title', 'asc')
                ->get();
            });
        });

         /*--------------- news list--------*/
         $this->app->singleton('newsList', function ($app) {
            return Cache::store('redis')->rememberForever('news', function () {
                return DB::table('portal_news')
                ->select('id as value','title as text','title as text_en',
                'title_bn as text_bn','status')
                ->orderBy('title', 'asc')
                ->get();
            });
        });

        /*--------------- faqs list--------*/
        $this->app->singleton('faqList', function ($app) {
            return Cache::store('redis')->rememberForever('faqs', function () {
                return DB::table('portal_faqs')
                ->select('id as value','title as text','title as text_en',
                'title_bn as text_bn','status')
                ->orderBy('title', 'asc')
                ->get();
            });
        });

        /*--------------- Complain list--------*/
        $this->app->singleton('complainTypeList', function ($app) {
            return Cache::store('redis')->rememberForever('complainType', function () {
                return DB::table('master_complain_types')
                ->select('id as value','com_type_name as text','com_type_name as text_en',
                'com_type_name_bn as text_bn','status')
                ->orderBy('com_type_name', 'asc')
                ->get();
            });
        });

        /*--------------- Complain Designation list--------*/
        $this->app->singleton('complainDesignationList', function ($app) {
            return Cache::store('redis')->rememberForever('complainDesignation', function () {
                return DB::table('master_complain_designations')
                ->select('id as value','org_id','designation_id','status')
                ->get();
            });
        });

          /*--------------- Complain send list--------*/
          $this->app->singleton('complainSendList', function ($app) {
            return Cache::store('redis')->rememberForever('complainSend', function () {
                return DB::table('com_complain_cycle')
                ->select('id as value','sender_id','complain_id', 'receiver_id', 'note as text','note as text_en',
                'note_bn as text_bn', 'status')
                ->orderBy('note', 'asc')
                ->get();
            });
        });

          /*--------------- PortalNotices list--------*/
          $this->app->singleton('PortalNoticeList', function ($app) {
            return Cache::store('redis')->rememberForever('PortalNotices', function () {
                return DB::table('portal_notices')
                ->select('id as value','title as text','title as text_en',
                'title_bn as text_bn','status')
                ->orderBy('title', 'asc')
                ->get();
            });
        });

          /*--------------- PortalHeader list--------*/
          $this->app->singleton('portalHeaderList', function ($app) {
            return Cache::store('redis')->rememberForever('PortalHeader', function () {
                return DB::table('portal_headers')
                ->select('id as value','title as text','title as text_en',
                'title_bn as text_bn','status')
                ->orderBy('title', 'asc')
                ->get();
            });
        });

        /*--------------- Complain Submit list--------*/
        $this->app->singleton('complainSubmitList', function ($app) {
            return Cache::store('redis')->rememberForever('complainSubmit', function () {
                return DB::table('com_complain_infos')
                ->select(
                    'id as value',
                    'org_id',
                    'component_id',
                    'module_id',
                    'service_id',
                    'division_id',
                    'district_id',
                    'upazila_id',
                    'union_id',
                    'com_title',
                    'com_title_bn',
                    'description',
                    'description_bn',
                    'status',
                )
                ->get();
            });
        });

        /*--------------- Complain Chain list--------*/
        $this->app->singleton('complainChainList', function ($app) {
            return Cache::store('redis')->rememberForever('complainChain', function () {
                return DB::table('master_complain_chains')
                ->select('id as value','org_id','designation_id','sorting_order','status')
                ->get();
            });
        });

        /*--------------- Component Designation list--------*/
        $this->app->singleton('ComponentDesignationList', function ($app) {
            return Cache::store('redis')->rememberForever('ComponentDesignation', function () {
                return DB::table('component_designations')
                ->select('id as value','org_id','component_id','designation_id','status')
                ->get();
            });
        });

        /*---------------externalPanelList--------*/
        $this->app->singleton('externalPanelList', function ($app) {
            return Cache::store('redis')->rememberForever('externalPanel', function () {
                return DB::table('external_panels')
                    ->select('id as value','component_id','name as text','name as text_en',
                        'name_bn as text_bn','sorting_order','description','description_bn','icon','status')
                    ->orderBy('name', 'asc')
                    ->get();
            });
        });

        /*---------------externalMenuList--------*/
        $this->app->singleton('externalMenuList', function ($app) {
            return Cache::store('redis')->rememberForever('externalMenu', function () {
                return DB::table('external_menus')
                    ->select('id as value','external_panel_id','name as text','name as text_en',
                        'name_bn as text_bn','url','sorting_order','icon','status')
                    ->orderBy('name', 'asc')
                    ->get();
            });
        });
    }

    /**
     * Bootstrap services.
     *
     * @return void
     */
    public function boot()
    { }
}
