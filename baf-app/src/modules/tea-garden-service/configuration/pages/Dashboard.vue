<template>
  <div class="section-wrapper">
    <breadcumb />
    <b-overlay :show="loading">
      <div class="form-wrapper bms-db-wrapper">
        <b-card>
          <b-card-text>
            <b-row>
              <b-col sm="4">
                <b-form-group id="input-group-3" label="Fiscal Year" label-for="input-3">
                  <b-form-select id="input-3" required>
                    <b-form-select-option value="2020">2020</b-form-select-option>
                    <b-form-select-option value="2021">2021</b-form-select-option>
                    <b-form-select-option value="2022">2022</b-form-select-option>
                    <b-form-select-option value="2023">2023</b-form-select-option>
                  </b-form-select>
                </b-form-group>
              </b-col>
              <b-col sm="4">
                <b-form-group id="input-group-3" label="Organization" label-for="input-3">
                  <b-form-select id="input-3" required>
                    <b-form-select-option value="2020">BTB</b-form-select-option>
                    <b-form-select-option value="2021">BTRI</b-form-select-option>
                    <b-form-select-option value="2022">PDU</b-form-select-option>
                    <b-form-select-option value="2023">Tea Garden</b-form-select-option>
                  </b-form-select>
                </b-form-group>
              </b-col>
              <b-col sm="4">
                <b-form-group id="input-group-3" label="Services" label-for="input-3" placebolder="Select Service">
                  <b-form-select id="input-3" required>
                    <b-form-select-option value="2020" selected>Service</b-form-select-option>
                    <b-form-select-option value="2021">Service</b-form-select-option>
                    <b-form-select-option value="2022">Service</b-form-select-option>
                    <b-form-select-option value="2023">Service</b-form-select-option>
                  </b-form-select>
                </b-form-group>
              </b-col>
            </b-row>
          </b-card-text>
        </b-card>
      </div>
      <!-- tea gardens dashboard -->
        <div>
          <div class="mb-1">
              <b-button block
                class="faq-btn text-left">
                <div class="d-flex justify-content-between">
                  <p>{{ $t('teaGardenConfig.tea_garden_dashboard') }}</p>
                </div>
              </b-button>
              <div class="faq-body mt-2">
                <div class="form-wrapper fertilizer-distribution">
                  <b-card class="total-gardens">
                    <b-card-text>
                      <b-row no-gutters>
                        <b-col sm="6">
                          <div class="total-garden-card">
                            <i class="ri-seedling-fill"></i>
                            <div class="content">
                              <p>{{ $t('teaGardenDashboard.total_gandens') }}</p>
                              <h3>{{ $n(masterTeaGardenGenInfoList.length) }}</h3>
                            </div>
                          </div>
                        </b-col>
                        <b-col sm="6">
                          <img src="../../../../assets/images/tea_gardens.jpg" class="img-fluid" alt="">
                        </b-col>
                      </b-row>
                    </b-card-text>
                  </b-card>
                  <b-card title="Fartilizer Distribution">
                    <b-card-text class="mb-3">
                      <b-row>
                        <b-col sm="4">
                          <div class="info-card submitted">
                            <div class="icon">
                              <i class="ri-folder-received-fill"></i>
                            </div>
                            <div class="content">
                              <p>Total Indent Submitted</p>
                              <h3>167</h3>
                            </div>
                          </div>
                        </b-col>
                        <b-col sm="4">
                          <div class="info-card approved">
                            <div class="icon">
                              <i class="ri-checkbox-fill"></i>
                            </div>
                            <div class="content">
                              <p>Approved Indent</p>
                              <h3>107</h3>
                            </div>
                          </div>
                        </b-col>
                        <b-col sm="4">
                          <div class="info-card pending">
                            <div class="icon">
                              <i class="ri-time-fill"></i>
                            </div>
                            <div class="content">
                              <p>Pending Indent</p>
                              <h3>07</h3>
                            </div>
                          </div>
                        </b-col>
                        <b-col sm="4">
                          <div class="info-card requested-far">
                            <div class="icon">
                              <i class="ri-share-circle-fill"></i>
                            </div>
                            <div class="content">
                              <p>Requested Fartilizer Qty</p>
                              <h3>1672 M.Ton</h3>
                            </div>
                          </div>
                        </b-col>
                        <b-col sm="4">
                          <div class="info-card approved-far">
                            <div class="icon">
                              <i class="ri-shield-check-fill"></i>
                            </div>
                            <div class="content">
                              <p>Approved Fartilizer Qty</p>
                              <h3>800 M. Ton</h3>
                            </div>
                          </div>
                        </b-col>
                      </b-row>
                    </b-card-text>
                  </b-card>
                  <b-card>
                    <b-card-text>
                      <img src="../../../../assets/images/chart-dark.png" class="img-fluid" alt="">
                    </b-card-text>
                  </b-card>
                </div>
              </div>
          </div>
          <!-- Tree Disposal NOC -->
          <div class="mb-1">
            <b-button block
              class="faq-btn text-left">
              <div class="d-flex justify-content-between">
                <p>Tree Disposal NOC</p>
              </div>
            </b-button>
            <div class="faq-body">
              <div class="form-wrapper fertilizer-distribution">
                      <b-row>
                        <b-col sm="3">
                          <div class="info-card total-app">
                            <div class="icon">
                              <i class="ri-file-3-fill"></i>
                            </div>
                            <div class="content">
                              <p>Total Application</p>
                              <h3>0</h3>
                            </div>
                          </div>
                        </b-col>
                        <b-col sm="3">
                          <div class="info-card approved">
                            <div class="icon">
                              <i class="ri-checkbox-circle-fill"></i>
                            </div>
                            <div class="content">
                              <p>Approved Application</p>
                              <h3>0</h3>
                            </div>
                          </div>
                        </b-col>
                        <b-col sm="3">
                          <div class="info-card pending">
                            <div class="icon">
                              <i class="ri-time-fill"></i>
                            </div>
                            <div class="content">
                              <p>Pending Application</p>
                              <h3>0</h3>
                            </div>
                          </div>
                        </b-col>
                        <b-col sm="3">
                          <div class="info-card reject">
                            <div class="icon">
                              <i class="ri-close-line"></i>
                            </div>
                            <div class="content">
                              <p>Rejected Application</p>
                              <h3>0</h3>
                            </div>
                          </div>
                        </b-col>
                      </b-row>
                  <b-card>
                    <b-card-text>
                      <img src="../../../../assets/images/chart-dark.png" class="img-fluid" alt="">
                    </b-card-text>
                  </b-card>
              </div>
            </div>
          </div>
          <!-- Small Tea Garden Resistration & Reniew -->
          <div class="mb-1">
            <b-button block
              class="faq-btn text-left">
              <div class="d-flex justify-content-between">
                <p>Small Tea Garden Resistration & Reniew</p>
              </div>
            </b-button>
            <div class="faq-body">
              <div class="form-wrapper fertilizer-distribution">
                      <b-row>
                        <b-col sm="3">
                          <div class="info-card total-app">
                            <div class="icon">
                              <i class="ri-file-3-fill"></i>
                            </div>
                            <div class="content">
                              <p>Total Application</p>
                              <h3>0</h3>
                            </div>
                          </div>
                        </b-col>
                        <b-col sm="3">
                          <div class="info-card approved">
                            <div class="icon">
                              <i class="ri-checkbox-circle-fill"></i>
                            </div>
                            <div class="content">
                              <p>Approved Application</p>
                              <h3>0</h3>
                            </div>
                          </div>
                        </b-col>
                        <b-col sm="3">
                          <div class="info-card pending">
                            <div class="icon">
                              <i class="ri-time-fill"></i>
                            </div>
                            <div class="content">
                              <p>Pending Application</p>
                              <h3>0</h3>
                            </div>
                          </div>
                        </b-col>
                        <b-col sm="3">
                          <div class="info-card reject">
                            <div class="icon">
                              <i class="ri-close-line"></i>
                            </div>
                            <div class="content">
                              <p>Rejected Application</p>
                              <h3>0</h3>
                            </div>
                          </div>
                        </b-col>
                        <b-col sm="3">
                          <div class="info-card total-app">
                            <div class="icon">
                              <i class="ri-file-3-fill"></i>
                            </div>
                            <div class="content">
                              <p>Total Application</p>
                              <small>(Reniew)</small>
                              <h3>0</h3>
                            </div>
                          </div>
                        </b-col>
                        <b-col sm="3">
                          <div class="info-card approved">
                            <div class="icon">
                              <i class="ri-checkbox-circle-fill"></i>
                            </div>
                            <div class="content">
                              <p>Approved Application</p>
                              <small>(Reniew)</small>
                              <h3>0</h3>
                            </div>
                          </div>
                        </b-col>
                        <b-col sm="3">
                          <div class="info-card pending">
                            <div class="icon">
                              <i class="ri-time-fill"></i>
                            </div>
                            <div class="content">
                              <p>Pending Application</p>
                              <small>(Reniew)</small>
                              <h3>0</h3>
                            </div>
                          </div>
                        </b-col>
                        <b-col sm="3">
                          <div class="info-card reject">
                            <div class="icon">
                              <i class="ri-close-line"></i>
                            </div>
                            <div class="content">
                              <p>Expired Application</p>
                              <small> &nbsp; </small>
                              <h3>0</h3>
                            </div>
                          </div>
                        </b-col>
                      </b-row>
                  <b-card>
                    <b-card-text>
                     <img src="../../../../assets/images/chart-dark.png" class="img-fluid" alt="">
                    </b-card-text>
                  </b-card>
              </div>
            </div>
          </div>
          <!-- Small Tea Farmer -->
          <div class="mb-1">
            <b-button block
              class="faq-btn text-left">
              <div class="d-flex justify-content-between">
                <p>Small Tea Farmer</p>
              </div>
            </b-button>
            <div class="faq-body">
              1
            </div>
          </div>
          <!-- Tea Factory Dashboard-->
          <div class="mb-1">
            <b-button block
              class="faq-btn text-left">
              <div class="d-flex justify-content-between">
                <p>Tea Factory Dashboard</p>
              </div>
            </b-button>
            <div class="faq-body">
              1
            </div>
          </div>
          <!-- Return Form-->
          <div class="mb-1">
            <b-button block
              class="faq-btn text-left">
              <div class="d-flex justify-content-between">
                <p>Return Form</p>
              </div>
            </b-button>
            <div class="faq-body">
              1
            </div>
          </div>
          <!-- Education Trust Scholarship -->
          <div class="mb-1">
            <b-button block
              class="faq-btn text-left">
              <div class="d-flex justify-content-between">
                <p>Education Trust Scholarship</p>
              </div>
            </b-button>
            <div class="faq-body">
              1
            </div>
          </div>
          <!-- Professional Course Management -->
          <div class="mb-1">
            <b-button block
              class="faq-btn text-left">
              <div class="d-flex justify-content-between">
                <p>Professional Course Management</p>
              </div>
            </b-button>
            <div class="faq-body">
              1
            </div>
          </div>
          <!-- Regular Garden Inspaction -->
          <div class="mb-1">
            <b-button block
              class="faq-btn text-left">
              <div class="d-flex justify-content-between">
                <p>Regular Garden Inspaction</p>
              </div>
            </b-button>
            <div class="faq-body">
              1
            </div>
          </div>
          <!-- Clone/Bi-Clone Management -->
          <div class="mb-1">
            <b-button block
              class="faq-btn text-left">
              <div class="d-flex justify-content-between">
                <p>Clone/Bi-Clone Management</p>
              </div>
            </b-button>
            <div class="faq-body">
              1
            </div>
          </div>
          <!-- TEA PLANT SUPPLY -->
          <div class="mb-1">
            <b-button block
              class="faq-btn text-left">
              <div class="d-flex justify-content-between">
                <p>Tea Plant Supply</p>
              </div>
            </b-button>
            <div class="faq-body">
              1
            </div>
          </div>
          <!-- Soil Sample Test -->
          <div class="mb-1">
            <b-button block
              class="faq-btn text-left">
              <div class="d-flex justify-content-between">
                <p>Soil Sample Test</p>
              </div>
            </b-button>
            <div class="faq-body">
              1
            </div>
          </div>
          <!-- Training and Workshop -->
          <div class="mb-1">
            <b-button block
              class="faq-btn text-left">
              <div class="d-flex justify-content-between">
                <p>Training and Workshop</p>
              </div>
            </b-button>
            <div class="faq-body">
              1
            </div>
          </div>
          <!-- Tea Garden Avisory Visit -->
          <div class="mb-1">
            <b-button block
              class="faq-btn text-left">
              <div class="d-flex justify-content-between">
                <p>Tea Garden Avisory Visit</p>
              </div>
            </b-button>
            <div class="faq-body">
              1
            </div>
          </div>
        </div>
    </b-overlay>
  </div>
</template>
<script>
export default {
  data () {
    return {
      dashboardData: {
      },
      loading: false
    }
  },
  computed: {
    masterTeaGardenGenInfoList () {
        return this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.filter(item => item.status === 1)
    }
  },
  created () {
  },
  methods: {
  }
}
</script>
<style>
.faq-body{
  margin-top: 1rem;
}
.faq-accordion {
  background-color: #F4F4F4 !important;
}

.faq-accordion .faq-body {
  padding: 10px;
  background-color: #ffffff !important;
  border: 1px solid #ddd !important;
  border-top: none;
}

.faq-btn {
  padding: 0.48rem 0.75rem;
  color: var(--alt) !important;
  border-color: var(--gray-ddd) !important;
  background-color: var(--gray-ddd) !important;
}

.faq-btn .down-arrow {
  display: block;
}

.faq-btn.not-collapsed .up-arrow {
  display: block;
}

.faq-btn.not-collapsed .down-arrow {
  display: none;
}
</style>
