<template>
    <div class="bpc-question-ans">
        <b-container class="portal-container">
            <h5 class="text-center pb-3">{{ $t('portal.question_and_answer') }}</h5>
            <b-row>
                <b-col sm="9">
                    <div class="question-form-wrapper">
                        <b-row>
                            <b-col>
                                <div class="question-form">
                                    <h6 class="box-title"><i class="ri-questionnaire-fill"></i> {{ $t('portal.ask_anything') }}</h6>
                                    <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
                                        <b-overlay :show="loading">
                                        <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
                                            <b-row>
                                            <b-col xs="12" sm="12" md="6">
                                                <ValidationProvider name="Name" vid="name" rules="required" v-slot="{ errors }">
                                                <b-form-group
                                                    label-for="name">
                                                    <template v-slot:label>
                                                    {{ $t('globalTrans.name') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input
                                                    id="name"
                                                    v-model="form.name"
                                                    :state="errors[0] ? false : (valid ? true : null)"
                                                    ></b-form-input>
                                                    <div class="invalid-feedback">
                                                    {{ errors[0] }}
                                                    </div>
                                                </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col xs="12" sm="12" md="6">
                                                <ValidationProvider name="Email Address" vid="email_address" v-slot="{ errors }" rules="required|email">
                                                <b-form-group
                                                    label-for="email_address">
                                                    <template v-slot:label>
                                                    {{ $t('eBizConfig.email_address') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input
                                                    id="email_address"
                                                    type="email"
                                                    v-model="form.email_address"
                                                    :state="errors[0] ? false : (valid ? true : null)"
                                                    ></b-form-input>
                                                    <div class="invalid-feedback">
                                                    {{ errors[0] }}
                                                    </div>
                                                </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col xs="12" sm="12" md="6">
                                                <ValidationProvider name="Contact Number" vid="contact_number" rules="required|min:11|max:11" v-slot="{ errors }">
                                                    <b-form-group
                                                    label-for="contact_number">
                                                    <template v-slot:label>
                                                        {{ $t('bfti.contact_number') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input
                                                        id="contact_number"
                                                        v-model="form.mobile_no"
                                                        :state="errors[0] ? false : (valid ? true : null)"
                                                    ></b-form-input>
                                                    <div class="invalid-feedback">
                                                        {{ errors[0] }}
                                                    </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="12">
                                            <ValidationProvider name="Question" vid="question" v-slot="{ errors }" rules="required">
                                            <b-form-group
                                                label-for="question">
                                                <template v-slot:label>
                                                {{ $t('eBizConfig.question') }}
                                                </template>
                                                <b-form-textarea
                                                    id="question"
                                                    rows="3"
                                                    placeholder="Type question..."
                                                    v-model="form.question"
                                                    :state="errors[0] ? false : (valid ? true : null)"
                                                ></b-form-textarea>
                                                <div class="invalid-feedback">
                                                {{ errors[0] }}
                                                </div>
                                            </b-form-group>
                                            </ValidationProvider>
                                            </b-col>
                                            </b-row>
                                            <b-row class="text-right">
                                            <b-col>
                                                <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ $t('globalTrans.submit') }}</b-button>
                                            </b-col>
                                            </b-row>
                                        </b-form>
                                        </b-overlay>
                                    </ValidationObserver>
                                    <!-- <div class="question-box">
                                        <b-form-textarea id="textarea-rows" placeholder="Type question..." rows="4"></b-form-textarea>
                                        <b-button class="" variant="info">Submit</b-button>
                                    </div> -->
                                </div>
                            </b-col>
                        </b-row>
                    </div>
                    <b-overlay :show="loading">
                    <div class="queestion-ans">
                        <b-row>
                            <b-col cols="12" v-for="(question, index) in questions" :key="index">
                                <div class="ans-item">
                                    <div class="user-meta">
                                        <img src="../../../../assets/images/man.png" alt="" class="profile-pic">
                                        <p class="user-name">{{  question.name }}</p>
                                    </div>
                                    <h5 class="question">{{  question.question }}</h5>
                                    <div class="ans-wrapper">
                                        <div class="ans-meta text-muted"><span>Answare by:</span><p class="auth">Admin</p></div>
                                        <p class="ans">
                                                {{ $i18n.locale === 'en' ? question.answer_en : question.answer_bn }}
                                        </p>
                                    </div>
                                </div>
                            </b-col>
                        </b-row>
                    </div>
                    </b-overlay>
                </b-col>
                <b-col sm="3">
                    <div class="question-sidebar">
                        <span class="sidebar-title">
                            <h5>Recent Questions</h5>
                        </span>
                        <b-list-group>
                            <b-list-group-item href="#" class="question-item">
                                <h6 class="mb-1">Do I need to have a undergrad percentage of 70%?</h6>
                                <p class="ans mb-1">
                                    Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.
                                </p>
                            </b-list-group-item>
                            <b-list-group-item href="#" class="question-item">
                                <h6 class="mb-1">Do I need to have a undergrad percentage of 70%?</h6>
                                <p class="ans mb-1">
                                    Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.
                                </p>
                            </b-list-group-item>
                            <b-list-group-item href="#" class="question-item">
                                <h6 class="mb-1">Do I need to have a undergrad percentage of 70%?</h6>
                                <p class="ans mb-1">
                                    Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.
                                </p>
                            </b-list-group-item>
                        </b-list-group>
                    </div>
                </b-col>
            </b-row>
        </b-container>
    </div>
</template>
<script>
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { portalQuestionAndAnswerStore, portalQuestionAndAnswerList } from '../../api/routes'
export default {
    name: 'bpc_questions',
    data () {
        return {
            valid: null,
            errors: [],
            questions: [],
            form: {
                name: '',
                email_address: ''
            }
        }
    },
    created () {
        this.getQuestions()
    },
    methods: {
        async saveUpdate () {
            this.$store.dispatch('mutateCommonProperties', { loading: true })
            let result = null
            result = await RestApi.postData(eBizServiceBaseUrl, portalQuestionAndAnswerStore, this.form)

            if (result.success) {
                this.questions = result.data
                this.$store.dispatch('mutateCommonProperties', { loading: false })
                this.$toast.success({
                title: this.$t('globalTrans.success'),
                message: this.$t('globalTrans.save_msg'),
                color: '#D6E09B'
                })
                this.$nextTick(() => {
                    this.form = {}
                    this.$refs.form.reset()
                })
            } else {
                this.$refs.form.setErrors(result.errors)
            }
        },
        async getQuestions () {
            this.$store.dispatch('mutateCommonProperties', { loading: true })
            let result = null
            result = await RestApi.getData(eBizServiceBaseUrl, portalQuestionAndAnswerList)

            if (result.success) {
                this.$store.dispatch('mutateCommonProperties', { loading: false })
                this.questions = result.data
            }
        }
    },
    computed: {
        loading: function () {
        return this.$store.state.commonObj.loading
        }
    }
}
</script>
<style>
.bpc-question-ans{
    padding: 2rem 0;
}
.bpc-question-ans .question-form-wrapper .question-form{
    width: 100%;
    height: auto;
    border-radius: .3rem;
    padding: 1rem;
    background: #E7EAFF;
}
.bpc-question-ans .question-form-wrapper .question-form .box-title{
    padding: 0 0 1rem 0;
}
.bpc-question-ans .question-form-wrapper .question-form .question-box{
    text-align: right;
}
.bpc-question-ans .queestion-ans{
    margin: 1.5rem 0;
}
.bpc-question-ans .queestion-ans .ans-item{
    padding: 1rem;
    margin-bottom: 1.5rem;
    border-radius: .4rem;
    background: #fff;
    border: 1px solid rgba(99, 99, 99, 0.2);
    /* box-shadow: rgba(99, 99, 99, 0.2) 0px 2px 8px 0px; */
}
.bpc-question-ans .queestion-ans .ans-item .user-meta{
    width: 100%;
    display: inline-flex;
    align-items: center;
}
.bpc-question-ans .queestion-ans .ans-item .user-meta .profile-pic{
    width: 100%;
    max-width: 40px;
    display: block;
    border-radius: 40px;
    border: 1px solid #E7EAFF;
}
.bpc-question-ans .queestion-ans .ans-item .user-meta .user-name{
    margin-left: .8rem;
}
.bpc-question-ans .queestion-ans .ans-item .question{
    text-transform: uppercase;
    margin-bottom: .4rem;
}
.bpc-question-ans .queestion-ans .ans-item .ans-wrapper{
    margin-left: 3.5rem;
}
.bpc-question-ans .queestion-ans .ans-item .ans-wrapper .ans{
    margin: .3rem 0;
}
.bpc-question-ans .queestion-ans .ans-item .ans-wrapper .ans-meta{
    padding: .5rem 0;
    display: flex;
    align-items: center;
    position: relative;
}
.bpc-question-ans .queestion-ans .ans-item .ans-wrapper .ans-meta::after{
    position: absolute;
    top: 50%;
    left: 20%;
    z-index: 1;
    content: "";
    width: 80%;
    border: 1px solid #ddd;
}
.bpc-question-ans .queestion-ans .ans-item .ans-wrapper .ans-meta .auth{
    padding-left: .5rem;
    background: #fff;
    z-index: 2;
}
.bpc-question-ans .question-sidebar{
    width: 100%;
}
.bpc-question-ans .question-sidebar .sidebar-title{
    width: 100%;
    color: #fff;
    padding: .4rem 1rem;
    display: block;
    border-radius: .5rem .5rem 0 0;
    background: var(--portal-brand);
}
.bpc-question-ans .question-sidebar .question-item .ans{
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
}
</style>
