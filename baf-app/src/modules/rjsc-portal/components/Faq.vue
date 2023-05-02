<template>
    <div>
        <Header />
        <b-container>
            <b-row class="py-4">
                <b-col sm="12" md="8">
                    <div class="page-title">
                        <h5>Frequently Asked Questions</h5>
                    </div>
                    <div class="faq-search">
                        <h5>We're here to Help</h5>
                        <div class="faq-search-input">
                            <b-form-input v-model="text" placeholder="Ask Question..."></b-form-input>
                            <b-button class="faq-srs-btn"><i class="ri-search-2-line"></i></b-button>
                        </div>
                    </div>
                    <div class="faq-wrapper">
                        <div class="accordion" role="tablist" v-for="(item, i) in accordions" :key="i">
                            <b-card no-body class="mb-1 border-none">
                                <b-card-header header-tag="header" class="p-0" role="tab">
                                    <b-button
                                        @click="(single_faq.answer === i) ? single_faq.answer ='' : single_faq.answer = i"
                                        class="faq-btn" block variant="text-left">
                                        <span class="d-flex justify-content-between">
                                            {{ item.ques }}
                                            <i class="faq-btn-icon"> {{ single_faq.answer === i ? '-' : '+' }} </i>
                                        </span>
                                    </b-button>
                                </b-card-header>
                                <b-collapse v-if="single_faq.answer === i" visible accordion="my-accordion"
                                    role="tabpanel">
                                    <b-card-body>
                                        <b-card-text>
                                            {{ item.ans }}
                                        </b-card-text>
                                    </b-card-body>
                                </b-collapse>
                            </b-card>
                        </div>
                    </div>
                </b-col>
                <b-col sm="12" md="4">
                    <News class="mb-4"></News>
                    <Notice />
                </b-col>
            </b-row>
        </b-container>
        <Footer />
    </div>
</template>
<script>
import Header from '../common/Header.vue'
import Footer from '../common/Footer.vue'
import Notice from './Notice.vue'
import News from './News.vue'
export default {
    name: 'Faq',
    components: {
        Header,
        Footer,
        Notice,
        News
    },
    data: () => ({
        accordions: [
            {
                ques: 'Anim pariatur cliche reprehenderit?',
                ans:
                `
                Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore VHS.

                `
            },
            {
                ques: 'Anim pariatur cliche reprehenderit?',
                ans:
                `
                Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore VHS.

                `
            },
            {
                ques: 'Anim pariatur cliche reprehenderit?',
                ans:
                `
                Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore VHS.

                `
            },
            {
                ques: 'Anim pariatur cliche reprehenderit?',
                ans:
                `
                Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore VHS.
                
                `
            }
        ],
        single_faq: {
            answer: 0
        }
    })
}
</script>
<style>
.border-none{
    border: none;
    border-color: transparent;
    padding: 0;
}
.page-title {
    width: 100%;
    padding: .5em 0;
    border-radius: .3em;
    text-align: center;
    color: var(--white);
    background-color: var(--rjsc-brand);
}
.faq-search{
    width: 100%;
    margin-top: 1em;
    padding: .7em;
    text-align: center;
    border: 1px solid #ddd;
    background-color: #ffc124;
}
.faq-search .form-control{
    margin: 0;
    height: calc(1.8em + 0.75rem + 2px);
}
.faq-search .faq-search-input{
    margin-top: 10px;
    position: relative;
}
.faq-search .faq-search-input .faq-srs-btn{
    position: absolute;
    top: 0;
    right: 0;
    font-size: 24px;
    padding: 18px;
    line-height: 0px;
    color: rgb(43, 43, 43);
    background: transparent!important;
    border: none;
}
.faq-wrapper{
    margin-top: 1em;
}
.faq-wrapper .accordion .card header.card-header .not-collapsed{
    border-color: transparent;
    color: black;
    background: rgb(202, 202, 202);
}
.faq-wrapper .accordion .card .collapse.show{
    border: none;
}
.faq-btn{
    color: #222;
    background-color: rgba(148, 148, 148, 0.25);
}
.faq-btn-icon{
    font-size: 26px;
    line-height: 24px;
    font-weight: 300;
    font-style: normal;
}
</style>
