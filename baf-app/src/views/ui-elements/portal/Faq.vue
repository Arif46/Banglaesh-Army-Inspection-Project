<template>
    <div class="portal">
        <b-card text-variant="dark" header-tag="header" class="faq-accordion">
            <template #header>
                <div class="d-flex justify-content-between align-items-center">
                    <div class="d-flex card-title-wrapper">
                        <h6 class="mb-0 ml-2">Faq</h6>
                    </div>
                    <a href="javascript:" class="pr-3 portal-text">See More <i class="ri-arrow-right-line"></i></a>
                </div>
            </template>
            <div role="tablist">
                <div class="mb-1">
                    <div header-tag="header" class="faq-card" role="tab">
                        <b-button block v-b-toggle.accordion-1 class="faq-btn text-left">
                            <div class="d-flex justify-content-between">
                                <p>How do I apply for name clearance?</p>
                                <i class="ri-arrow-up-s-line up-arrow"></i>
                                <i class="ri-arrow-down-s-line down-arrow"></i>
                            </div>
                        </b-button>
                    </div>
                    <b-collapse id="accordion-1" visible accordion="my-accordion" role="tabpanel">
                        <div class="faq-body">
                            <b-card-text>I start opened because <code>visible</code> is <code>true</code></b-card-text>
                            <b-card-text>{{ text }}</b-card-text>
                        </div>
                    </b-collapse>
                </div>

                <div class="mb-1">
                    <div header-tag="header" role="tab">
                        <b-button block v-b-toggle.accordion-2 class="faq-btn text-left">
                            <div class="d-flex justify-content-between">
                                <p>I want to know daily market rate info</p>
                                <i class="ri-arrow-up-s-line up-arrow"></i>
                                <i class="ri-arrow-down-s-line down-arrow"></i>
                            </div>
                        </b-button>
                    </div>
                    <b-collapse id="accordion-2" accordion="my-accordion" role="tabpanel">
                        <div class="faq-body">
                            <b-card-text>{{ text }}</b-card-text>
                        </div>
                    </b-collapse>
                </div>

                <div class="mb-1">
                    <div header-tag="header" role="tab">
                        <b-button block v-b-toggle.accordion-3 class="faq-btn text-left">
                            <div class="d-flex justify-content-between">
                                <p>Ministry of Commerce Location</p>
                                <i class="ri-arrow-up-s-line up-arrow"></i>
                                <i class="ri-arrow-down-s-line down-arrow"></i>
                            </div>
                        </b-button>
                    </div>
                    <b-collapse id="accordion-3" accordion="my-accordion" role="tabpanel">
                        <div class="faq-body">
                            <b-card-text>{{ text }}</b-card-text>
                        </div>
                    </b-collapse>
                </div>
                <div class="mb-1">
                    <div header-tag="header" role="tab">
                        <b-button block v-b-toggle.accordion-4 class="faq-btn text-left">
                            <div class="d-flex justify-content-between">
                                <p>I want to know daily market rate info</p>
                                <i class="ri-arrow-up-s-line up-arrow"></i>
                                <i class="ri-arrow-down-s-line down-arrow"></i>
                            </div>
                        </b-button>
                    </div>
                    <b-collapse id="accordion-4" accordion="my-accordion" role="tabpanel">
                        <div class="faq-body">
                            <b-card-text>{{ text }}</b-card-text>
                        </div>
                    </b-collapse>
                </div>
                <div class="mb-1">
                    <div header-tag="header" role="tab">
                        <b-button block v-b-toggle.accordion-5 class="faq-btn text-left">
                            <div class="d-flex justify-content-between">
                                <p>Ministry of Commerce Location</p>
                                <i class="ri-arrow-up-s-line up-arrow"></i>
                                <i class="ri-arrow-down-s-line down-arrow"></i>
                            </div>
                        </b-button>
                    </div>
                    <b-collapse id="accordion-5" accordion="my-accordion" role="tabpanel">
                        <div class="faq-body">
                            <b-card-text>{{ text }}</b-card-text>
                        </div>
                    </b-collapse>
                </div>
                <div class="mb-1">
                    <div header-tag="header" role="tab">
                        <b-button block v-b-toggle.accordion-6 class="faq-btn text-left">
                            <div class="d-flex justify-content-between">
                                <p>Ministry of Commerce Location</p>
                                <i class="ri-arrow-up-s-line up-arrow"></i>
                                <i class="ri-arrow-down-s-line down-arrow"></i>
                            </div>
                        </b-button>
                    </div>
                    <b-collapse id="accordion-6" accordion="my-accordion" role="tabpanel">
                        <div class="faq-body">
                            <b-card-text>{{ text }}</b-card-text>
                        </div>
                    </b-collapse>
                </div>
            </div>
        </b-card>
    </div>
</template>
<script>
export default {
    name: 'Faq',
    data () {
        return {
            text: 'Answer:- Agricultural Service Portal Agricultural Service Portal Agricultural Service Portal'
        }
    }
}
</script>
<style>
.faq-accordion{
    background-color: #F4F4F4!important;
}
.faq-accordion .faq-body{
    padding: 10px;
    background-color: #ffffff!important;
    border: 1px solid #ddd!important;
    border-top: none;
}
.faq-btn{
    padding: 0.48rem 0.75rem;
    color: var(--white) !important;
    border-color: var(--gray-ddd) !important;
    background-color: var(--portal-secondary) !important;
}
.faq-btn.not-collapsed{
  color: #fff!important;
  background-color: #1d4ff4!important;
}
.faq-btn .up-arrow{
    display: none;
}
.faq-btn .down-arrow{
    display: block;
}
.faq-btn.not-collapsed .up-arrow{
  display: block;
}
.faq-btn.not-collapsed .down-arrow{
  display: none;
}
</style>
