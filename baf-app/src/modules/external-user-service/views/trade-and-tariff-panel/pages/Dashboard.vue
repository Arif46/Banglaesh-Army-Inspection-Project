<template>
    <div class="ex_panel_tfair">
        <b-breadcrumb class="custom-bread">
            <b-breadcrumb-item href="#">Tread Tariff Panel</b-breadcrumb-item>
            <b-breadcrumb-item active>Dashboard</b-breadcrumb-item>
        </b-breadcrumb>
        <b-row>
            <b-col>
                <b-card class="mt-1" title="International Trade Tariff Calender">
                    <b-row>
                        <b-col sm="4">
                            <b-form-group>
                                <template v-slot:label>
                                    Fiscal Year
                                </template>
                                <b-form-select>
                                    <template v-slot:first>
                                        <b-form-select-option value="1">2021 - 2022</b-form-select-option>
                                        <b-form-select-option value="2">2022 - 2023</b-form-select-option>
                                        <b-form-select-option value="3">2023 - 2024</b-form-select-option>
                                    </template>
                                </b-form-select>
                            </b-form-group>
                        </b-col>
                        <b-col sm="4">
                            <b-form-group>
                                <template v-slot:label>
                                    Month
                                </template>
                                <b-form-select>
                                    <template v-slot:first>
                                        <b-form-select-option value="1">January</b-form-select-option>
                                        <b-form-select-option value="2">February</b-form-select-option>
                                        <b-form-select-option value="3">March</b-form-select-option>
                                        <b-form-select-option value="4">April</b-form-select-option>
                                        <b-form-select-option value="5">May</b-form-select-option>
                                        <b-form-select-option value="6">Jun</b-form-select-option>
                                    </template>
                                </b-form-select>
                            </b-form-group>
                        </b-col>
                        <b-col sm="4">
                            <b-form-group>
                                <template v-slot:label>
                                    Sector
                                </template>
                                <b-form-select>
                                    <template v-slot:first>
                                        <b-form-select-option value="1">Agricultural Products</b-form-select-option>
                                        <b-form-select-option value="2">Agro Processed Food</b-form-select-option>
                                        <b-form-select-option value="3">Book Fair</b-form-select-option>
                                        <b-form-select-option value="4">Furniture</b-form-select-option>
                                        <b-form-select-option value="5">General</b-form-select-option>
                                        <b-form-select-option value="6">Handicrafts</b-form-select-option>
                                    </template>
                                </b-form-select>
                            </b-form-group>
                        </b-col>
                    </b-row>
                    <div class="table-wrapper">
                        <b-table head-variant="custom" :tbody-tr-class="{ 'active-circular': isCircular }" :items="items" :fields="fields" :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" sort-icon-left
                             hover bordered responsive>
                            <template v-slot:cell(action)>
                                <a href="javascript:" title="View" class="action-btn status"><i class="ri-eye-fill"></i></a>
                                <a href="javascript:" title="Apply" class="action-btn active"><i class="ri-draft-fill"></i></a>
                            </template>
                        </b-table>
                    </div>
                </b-card>
            </b-col>
        </b-row>
        <!-- *********upcoming fair & calender********* -->
        <b-row>
            <b-col sm="8">
                <b-card class="upcoming-fair">
                    <div class="d-flex justifiy-center align-items-center flex-column">
                        <div class="icon mb-2">
                            <img class="img-fluid" src="../../../../../assets/images/local-shop.png" alt="image">
                        </div>
                        <div class="content">
                            <h5>The 4th International Tread Show for Aquaculture</h5>
                            <h6 class="py-3"><strong>City and Country: </strong> Riyadh, KSA</h6>
                            <p class="fair-date"><strong>Duration: </strong>17 October, 2022 to 20 October, 2022</p>
                        </div>
                    </div>
                </b-card>
            </b-col>
            <b-col sm="4">
                <b-card>
                    <img class="img-fluid" src="../../../../../assets/images/calender.png" alt="image">
                </b-card>
            </b-col>
        </b-row>
        <section>
            <b-row>
                <b-col>
                    <b-card title="Dhaka International Trade Fair">
                        <div class="ditf_participant mb-4">
                            <b-row>
                                <b-col class="bdr" sm="4">
                                    <div class="info-card applicant">
                                        <div class="icon"><i class="ri-team-fill"></i></div>
                                        <div class="content">
                                            <p>Total Stall</p>
                                            <h3>04</h3>
                                        </div>
                                    </div>
                                </b-col>
                                <b-col class="bdr mt-3 mt-sm-0" sm="4">
                                    <div class="info-card approved">
                                        <div class="icon"><i class="ri-checkbox-fill"></i></div>
                                        <div class="content">
                                            <p>Approved Stall</p>
                                            <h3>02</h3>
                                        </div>
                                    </div>
                                </b-col>
                                <b-col class="bdr" sm="4">
                                    <div class="info-card peinding">
                                        <div class="icon"><i class="ri-time-fill"></i></div>
                                        <div class="content">
                                            <p>Pending Stall</p>
                                            <h3>01</h3>
                                        </div>
                                    </div>
                                </b-col>
                                <b-col class="bdr mt-3" sm="4">
                                    <div class="info-card reject">
                                        <div class="icon"><i class="ri-close-circle-fill"></i></div>
                                        <div class="content">
                                            <p>Reject Stall</p>
                                            <h3>01</h3>
                                        </div>
                                    </div>
                                </b-col>
                                <b-col class="bdr mt-3" sm="4">
                                    <div class="info-card paid">
                                        <div class="icon"><i class="ri-user-follow-fill"></i></div>
                                        <div class="content">
                                            <p>Paid Stall</p>
                                            <h3>02</h3>
                                        </div>
                                    </div>
                                </b-col>
                                <b-col class="bdr mt-3" sm="4">
                                    <div class="info-card unpaid">
                                        <div class="icon"><i class="ri-user-unfollow-fill"></i></div>
                                        <div class="content">
                                            <p>Unpaid Stall</p>
                                            <h3>01</h3>
                                        </div>
                                    </div>
                                </b-col>
                            </b-row>
                        </div>
                    </b-card>
                </b-col>
            </b-row>
        </section>
    </div>
</template>

<script>
export default {
    data () {
        return {
            sortBy: 'division',
            sortDesc: false,
            isCircular: true,
            fields: [
                { key: 'sl', sortable: true },
                { key: 'name_of_event', sortable: true },
                { key: 'city_and_country', sortable: true },
                { key: 'duration', sortable: true },
                { key: 'action', sortable: false }
            ],
            items: [
                {
                    isActive: true,
                    sl: 1,
                    name_of_event: 'Malaysian International Foods and Beverage Exhibition',
                    city_and_country: 'Kualalumpur, Malaysia',
                    duration: 'July 28-30, 2021',
                    action: ''
                },
                {
                    isActive: true,
                    sl: 2,
                    name_of_event: 'SIAL Middle East, Abu Dhabi',
                    city_and_country: 'Abu Dhabi, UAE',
                    duration: 'Sep 7-9, 2021',
                    action: ''
                },
                {
                    isActive: true,
                    sl: 3,
                    name_of_event: 'World Food, Moscow',
                    city_and_country: 'Moscow, Russia',
                    duration: '21-24 September, 2021',
                    action: ''
                },
                {
                    isActive: true,
                    sl: 4,
                    name_of_event: 'Anuga Food Fair, 2021, Germany',
                    city_and_country: 'Colognem Germany',
                    duration: '09-13 October, 2021',
                    action: ''
                },
                {
                    isActive: true,
                    sl: 5,
                    name_of_event: 'Japan International Food Exhibition',
                    city_and_country: 'Tokyo',
                    duration: 'November, 2021',
                    action: ''
                }
            ]
        }
    }
}
</script>

<style>
.ex_panel_tfair thead.thead-custom {
    color: #fff;
    background: #77a0cb;
}
.ex_panel_tfair .active-circular{
    color: #2943d6;
}
.ex_panel_tfair .table-wrapper{
    margin-bottom: 2rem;
}
.ex_panel_tfair .upcoming-fair {
    background: url(../../../../../assets/images/fair-card-bg.jpg);
    background-position: 50%;
    background-repeat: no-repeat;
    background-size: cover !important;
    position: relative;
}

.ex_panel_tfair .upcoming-fair .icon img {
    width: 100px;
}

.ex_panel_tfair .upcoming-fair .content {
    padding: 2rem;
    width: 100%;
    color: #fff;
    text-align: center;
}
.ex_panel_tfair .ditf_participant .info-card {
    display: flex;
    align-items: center;
    padding: 1rem;
    border-radius: 4px;
    box-shadow: rgba(0, 0, 0, 0.16) 0px 1px 4px;
}

.ex_panel_tfair .ditf_participant .info-card .content {
    margin-left: .8rem;
}
.ex_panel_tfair .ditf_participant .info-card .icon {
    padding-right: 1rem;
    color: #fff;
    font-size: 1.5rem;
    margin-right: .6rem;
}

.ex_panel_tfair .ditf_participant .info-card.applicant {
    background: linear-gradient(90deg, #520979 20%, #f9efff 23%);
}

.ex_panel_tfair .ditf_participant .info-card.approved {
    background: rgb(33, 194, 40);
    background: linear-gradient(90deg, #21c228 20%, #effff0 23%);
}

.ex_panel_tfair .ditf_participant .info-card.peinding {
    background: #C96BE5;
    background: linear-gradient(90deg, #C96BE5 20%, #faebff 23%);
}

.ex_panel_tfair .ditf_participant .info-card.reject {
    background: #F8576A;
    background: linear-gradient(90deg, #F8576A 20%, #ffeef0 23%);
}

.ex_panel_tfair .ditf_participant .info-card.paid {
    background: #6349F8;
    background: linear-gradient(90deg, #6349F8 20%, #efecff 23%);
}

.ex_panel_tfair .ditf_participant .info-card.unpaid {
    background: #E79B55;
    background: linear-gradient(90deg, #E79B55 20%, #fff7ef 23%);
}

.ex_panel_tfair .ditf_participant .info-card.atended {
    background: #55A6F8;
    background: linear-gradient(90deg, #55A6F8 20%, #eaf5ff 23%);
}

.ex_panel_tfair .ditf_participant .info-card.foreign {
    background: #2943d6;
    background: linear-gradient(90deg, #2943d6 20%, #e9ecff 23%);
}
</style>
