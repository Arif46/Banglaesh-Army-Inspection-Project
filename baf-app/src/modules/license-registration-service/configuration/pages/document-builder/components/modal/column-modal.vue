<template>
    <b-row>
        <b-row>
            <b-col md="12" sm="12" lg="12">
                <span class="col-sm-12 text-left fields" v-for="item in componentList" :key="item.i" style="cursor:pointer;padding:10px" @click="addItem(item.dataType)">
                    <i class="mr-1" :class="item.icon"></i><span class="mr-1" >{{ item.text }}</span>
                </span>
            </b-col>
            <b-col md="12" sm="12" lg="12">
                <div v-for="(item, index) in inputData" :key="index" style="padding:15px;">
                    <b-row v-if="item.type === 'Empty'" class="border p-2" style="background-color:#ddd;">
                        <h3 class="mb-2">{{ item.type }}</h3>
                    </b-row>
                    <b-row v-if="item.type === 'DocumentID'" class="border p-2" style="background-color:#ddd;">
                        <h3 class="mb-2">{{ item.type }}</h3>
                    </b-row>
                    <b-row v-if="item.type === 'FirstIssueDate'" class="border p-2" style="background-color:#ddd;">
                        <h3 class="mb-2">{{ item.type }}</h3>
                    </b-row>
                    <b-row v-if="item.type === 'Paragraph'" class="border p-2" style="background-color:#ddd;">
                        <h3 class="mb-2">{{ item.type }}</h3>
                        <b-col md="12" sm="12" lg="12">
                            <ValidationProvider name="paragraph_text_en" vid="paragraph_text_en">
                                <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="paragraph_text_en"
                                >
                                    <template v-slot:label>
                                        {{$t('component_settings.para_text')}}
                                    </template>
                                    <b-form-textarea
                                    id="paragraph_text"
                                    v-model="item.value_en"
                                    :placeholder="$t('component_settings.para_text')"
                                    ></b-form-textarea>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col md="12" sm="12" lg="12">
                            <ValidationProvider name="paragraph_text_bn" vid="paragraph_text_bn">
                                <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="paragraph_text_bn"
                                >
                                    <template v-slot:label>
                                        {{$t('component_settings.para_text_bn')}}
                                    </template>
                                    <b-form-textarea
                                    id="paragraph_text_bn"
                                    v-model="item.value_bn"
                                    :placeholder="$t('component_settings.para_text_bn')"
                                    ></b-form-textarea>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col lg="12" sm="12" md="12">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="color"
                            >
                                <template v-slot:label>
                                    {{$t('component_settings.color')}}
                                </template>

                                <b-form-input
                                id="color"
                                v-model="item.color"
                                type="color"
                                ></b-form-input>
                            </b-form-group>
                        </b-col>
                        <b-col lg="12" sm="12" md="12">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="is_bold"
                            >
                                <template v-slot:label>
                                    {{$t('component_settings.is_bold')}}
                                </template>
                                <b-form-checkbox
                                    class="mt-2"
                                    id="is_bold"
                                    v-model="item.is_bold"
                                > <span v-if="item.is_bold">{{ $t('globalTrans.yes') }}</span><span v-else>{{ $t('globalTrans.no') }}</span>
                                </b-form-checkbox>
                            </b-form-group>
                        </b-col>
                    </b-row>
                    <b-row v-if="item.type === 'Header'" class="border p-2" style="background-color:#ddd;">
                        <h3 class="mb-2">{{ item.type }}</h3>
                        <b-col lg="12" sm="12" md="12">
                            <ValidationProvider name="Field Type" vid="field_type" rules="required">
                                <b-form-group
                                    class="row"
                                    label-cols-sm="3"
                                    label-for="field_type"
                                    slot-scope="{ valid, errors }"
                                >
                                    <template v-slot:label>
                                        {{$t('component_settings.field_type')}}<span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                    plain
                                    v-model="item.field_type"
                                    id="field_type"
                                    :options="inputTypeList"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                    >
                                    </b-form-select>
                                        <div class="invalid-feedback">
                                    {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col lg="12" sm="12" md="12">
                            <ValidationProvider name="header_value" vid="header_value">
                                <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="header_value"
                                >
                                    <template v-slot:label>
                                        {{$t('component_settings.header_text')}}
                                    </template>
                                    <b-form-input
                                    id="header_value"
                                    v-model="item.value_en"
                                    :placeholder="$t('component_settings.header_text')"
                                    ></b-form-input>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col lg="12" sm="12" md="12">
                            <ValidationProvider name="header_value" vid="header_value">
                                <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="header_value"
                                >
                                    <template v-slot:label>
                                        {{$t('component_settings.header_text_bn')}}
                                    </template>
                                    <b-form-input
                                    id="header_value"
                                    v-model="item.value_bn"
                                    :placeholder="$t('component_settings.header_text')"
                                    ></b-form-input>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col lg="12" sm="12" md="12">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="color"
                            >
                                <template v-slot:label>
                                    {{$t('component_settings.color')}}
                                </template>

                                <b-form-input
                                id="color"
                                v-model="item.color"
                                type="color"
                                ></b-form-input>
                            </b-form-group>
                        </b-col>
                    </b-row>
                    <b-overlay :show="loading">
                        <b-row v-if="item.type === 'InputField'" class="border p-2" style="background-color:#ddd;">
                            <b-col lg="12" sm="12" md="12">
                                <h3 class="mb-2">{{ item.type }} En</h3>
                            </b-col>
                            <b-col lg="4" sm="4" md="4">
                                <ValidationProvider name="Form" vid="form_id" rules="required|min_value:1">
                                    <b-form-group
                                    class="row"
                                    label-cols-sm="4"
                                    label-for="form_id"
                                    slot-scope="{ valid, errors }"
                                    >
                                    <template v-slot:label>
                                    {{ $t('dynamic_form.form') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                        plain
                                        v-model="item.formId"
                                        :options="formList"
                                        id="form_id"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        @change="getTabs(item)"
                                        >
                                        <template v-slot:first>
                                        <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                        </template>
                                    </b-form-select>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="4" sm="4" md="4">
                                <ValidationProvider name="Form Tab" vid="form_tab" rules="required">
                                    <b-form-group
                                    class="row"
                                    label-cols-sm="4"
                                    label-for="form_tab"
                                    slot-scope="{ valid, errors }"
                                    >
                                    <template v-slot:label>
                                    {{ $t('dynamic_form.form_tab') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                        plain
                                        v-model="item.tabName"
                                        :options="item.tabList"
                                        id="form_id"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        @change="getCols(item)"
                                        >
                                        <template v-slot:first>
                                        <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                        </template>
                                    </b-form-select>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="4" sm="4" md="4">
                                <ValidationProvider name="Form Column" vid="column" rules="required">
                                    <b-form-group
                                    class="row"
                                    label-cols-sm="4"
                                    label-for="column"
                                    slot-scope="{ valid, errors }"
                                    >
                                    <template v-slot:label>
                                    {{ $t('dynamic_form.column') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                        plain
                                        v-model="item.column"
                                        :options="item.colList"
                                        id="form_id"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        @change="getColId(item)"
                                        >
                                        <template v-slot:first>
                                        <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                        </template>
                                    </b-form-select>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="12" sm="12" md="12">
                                <h3 class="mb-2">{{ item.type }} Bn</h3>
                            </b-col>
                            <b-col lg="4" sm="4" md="4">
                                <ValidationProvider name="Form" vid="form_id" rules="required|min_value:1">
                                    <b-form-group
                                    class="row"
                                    label-cols-sm="4"
                                    label-for="form_id"
                                    slot-scope="{ valid, errors }"
                                    >
                                    <template v-slot:label>
                                    {{ $t('dynamic_form.form') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                        plain
                                        v-model="item.formId"
                                        :options="formList"
                                        id="form_id"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        @change="getTabs(item)"
                                        >
                                        <template v-slot:first>
                                        <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                        </template>
                                    </b-form-select>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="4" sm="4" md="4">
                                <ValidationProvider name="Form Tab" vid="form_tab" rules="required">
                                    <b-form-group
                                    class="row"
                                    label-cols-sm="4"
                                    label-for="form_tab"
                                    slot-scope="{ valid, errors }"
                                    >
                                    <template v-slot:label>
                                    {{ $t('dynamic_form.form_tab') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                        plain
                                        v-model="item.tabName"
                                        :options="item.tabList"
                                        id="form_id"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        @change="getCols(item)"
                                        >
                                        <template v-slot:first>
                                        <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                        </template>
                                    </b-form-select>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="4" sm="4" md="4">
                                <ValidationProvider name="Form Column" vid="column" rules="required">
                                    <b-form-group
                                    class="row"
                                    label-cols-sm="4"
                                    label-for="column"
                                    slot-scope="{ valid, errors }"
                                    >
                                    <template v-slot:label>
                                    {{ $t('dynamic_form.column') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                        plain
                                        v-model="item.columnBn"
                                        :options="item.colList"
                                        id="form_id"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        @change="getColBId(item)"
                                        >
                                        <template v-slot:first>
                                        <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                        </template>
                                    </b-form-select>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                        </b-row>
                    </b-overlay>
                    <b-overlay :show="loading">
                        <b-row v-if="item.type === 'Table'" class="border p-2" style="background-color:#ddd;">
                            <h3 class="mb-2">{{ item.type }}</h3>
                            <b-col lg="12" sm="12" md="12">
                                <ValidationProvider name="Form Title" vid="form_id" rules="required|min_value:1">
                                    <b-form-group
                                    class="row"
                                    label-cols-sm="4"
                                    label-for="form_id"
                                    slot-scope="{ valid, errors }"
                                    >
                                    <template v-slot:label>
                                    {{ $t('dynamic_form.form_title') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                        plain
                                        v-model="item.formId"
                                        :options="formList"
                                        id="form_id"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        @change="getTabs(item)"
                                        >
                                        <template v-slot:first>
                                        <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                        </template>
                                    </b-form-select>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="12" sm="12" md="12">
                                <ValidationProvider name="Form Tab" vid="form_tab" rules="required">
                                    <b-form-group
                                    class="row"
                                    label-cols-sm="4"
                                    label-for="form_tab"
                                    slot-scope="{ valid, errors }"
                                    >
                                    <template v-slot:label>
                                    {{ $t('dynamic_form.form_tab') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                        plain
                                        v-model="item.tabName"
                                        :options="item.tabList"
                                        id="form_id"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        @change="getCols(item)"
                                        >
                                        <template v-slot:first>
                                        <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                        </template>
                                    </b-form-select>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="12" sm="12" md="12">
                                <ValidationProvider name="Form Column" vid="column" rules="required">
                                    <b-form-group
                                    class="row"
                                    label-cols-sm="4"
                                    label-for="column"
                                    slot-scope="{ valid, errors }"
                                    >
                                    <template v-slot:label>
                                    {{ $t('dynamic_form.column') }} <span class="text-danger">*</span>
                                    </template>
                                    <v-select
                                        plain
                                        v-model="item.column"
                                        :options="item.colList"
                                        multiple
                                        id="form_id"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        >
                                        <template v-slot:first>
                                        <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                        </template>
                                    </v-select>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                        </b-row>
                    </b-overlay>
                    <b-overlay :show="loading">
                        <b-row v-if="item.type === 'QR'" class="border p-2" style="background-color:#ddd;">
                            <h3 class="mb-2">{{ item.type }}</h3>
                            <b-col lg="12" sm="12" md="12">
                                <ValidationProvider name="Form Title" vid="form_id" rules="required|min_value:1">
                                    <b-form-group
                                    class="row"
                                    label-cols-sm="3"
                                    label-for="form_id"
                                    slot-scope="{ valid, errors }"
                                    >
                                    <template v-slot:label>
                                    {{ $t('dynamic_form.form_title') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                        plain
                                        v-model="item.formId"
                                        :options="formList"
                                        id="form_id"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        @change="getTabs(item)"
                                        >
                                        <template v-slot:first>
                                        <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                        </template>
                                    </b-form-select>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="12" sm="12" md="12">
                                <ValidationProvider name="Form Tab" vid="form_tab" rules="required">
                                    <b-form-group
                                    class="row"
                                    label-cols-sm="3"
                                    label-for="form_tab"
                                    slot-scope="{ valid, errors }"
                                    >
                                    <template v-slot:label>
                                    {{ $t('dynamic_form.form_tab') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                        plain
                                        v-model="item.tabName"
                                        :options="item.tabList"
                                        id="form_id"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        @change="getCols(item)"
                                        >
                                        <template v-slot:first>
                                        <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                        </template>
                                    </b-form-select>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="12" sm="12" md="12">
                                <ValidationProvider name="QR Code" vid="qr_code" rules="required">
                                    <b-form-group
                                    class="row"
                                    label-cols-sm="3"
                                    label-for="qr_code"
                                    slot-scope="{ valid, errors }"
                                    >
                                    <template v-slot:label>
                                    {{ $t('component_settings.qr_code') }} <span class="text-danger">*</span>
                                    </template>
                                    <v-select
                                        plain
                                        v-model="item.column"
                                        :options="item.colList"
                                        multiple
                                        id="form_id"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        >
                                        <template v-slot:first>
                                        <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                        </template>
                                    </v-select>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="12" sm="12" md="12">
                                <ValidationProvider name="generate_id" vid="generate_id">
                                    <b-form-group
                                        class="row"
                                        label-cols-sm="3"
                                        label-for="generate_id"
                                    >
                                        <template v-slot:label>
                                            {{$t('component_settings.generate_id')}}
                                        </template>
                                        <b-form-checkbox
                                            class="mt-2"
                                            id="generate_id"
                                            v-model="qrFields.generate_id"
                                            @change="setGenId(item)"
                                        > <span v-if="qrFields.generate_id">{{ $t('globalTrans.yes') }}</span><span v-else>{{ $t('globalTrans.no') }}</span>
                                        </b-form-checkbox>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="12" sm="12" md="12">
                                <ValidationProvider name="expire_date" vid="expire_date">
                                    <b-form-group
                                        class="row"
                                        label-cols-sm="3"
                                        label-for="expire_date"
                                    >
                                        <template v-slot:label>
                                            {{$t('li_step.expire_date')}}
                                        </template>
                                        <b-form-checkbox
                                            class="mt-2"
                                            id="expire_date"
                                            v-model="qrFields.expire_date"
                                            @change="setExp(item)"
                                        > <span v-if="qrFields.expire_date">{{ $t('globalTrans.yes') }}</span><span v-else>{{ $t('globalTrans.no') }}</span>
                                        </b-form-checkbox>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                        </b-row>
                    </b-overlay>
                    <b-overlay>
                        <b-row v-if="item.type === 'Attachment'" class="border p-2" style="background-color:#ddd;">
                            <h3 class="mb-2">{{ item.type }}</h3>
                            <b-col lg="12" sm="12" md="12">
                                <ValidationProvider name="Attachment Type" vid="field_type" rules="required">
                                    <b-form-group
                                        class="row"
                                        label-cols-sm="3"
                                        label-for="field_type"
                                        slot-scope="{ valid, errors }"
                                    >
                                        <template v-slot:label>
                                            {{$t('component_settings.attachment_type')}}<span class="text-danger">*</span>
                                        </template>
                                        <b-form-select
                                        plain
                                        v-model="item.field_type"
                                        id="field_type"
                                        :options="fieldTypeList"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        >
                                        </b-form-select>
                                            <div class="invalid-feedback">
                                        {{ errors[0] }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="4" sm="4" md="4" v-if="item.field_type === 'dynamic'">
                                <ValidationProvider name="Form" vid="form_id" rules="required|min_value:1">
                                    <b-form-group
                                    class="row"
                                    label-cols-sm="4"
                                    label-for="form_id"
                                    slot-scope="{ valid, errors }"
                                    >
                                    <template v-slot:label>
                                    {{ $t('dynamic_form.form') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                        plain
                                        v-model="item.formId"
                                        :options="formList"
                                        id="form_id"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        @change="getTabs(item)"
                                        >
                                        <template v-slot:first>
                                        <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                        </template>
                                    </b-form-select>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="4" sm="4" md="4" v-if="item.field_type === 'dynamic'">
                                <ValidationProvider name="Form Tab" vid="form_tab" rules="required">
                                    <b-form-group
                                    class="row"
                                    label-cols-sm="4"
                                    label-for="form_tab"
                                    slot-scope="{ valid, errors }"
                                    >
                                    <template v-slot:label>
                                    {{ $t('dynamic_form.form_tab') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                        plain
                                        v-model="item.tabName"
                                        :options="item.tabList"
                                        id="form_id"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        @change="getCols(item)"
                                        >
                                        <template v-slot:first>
                                        <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                        </template>
                                    </b-form-select>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="4" sm="4" md="4" v-if="item.field_type === 'dynamic'">
                                <ValidationProvider name="Form Column" vid="column" rules="required">
                                    <b-form-group
                                    class="row"
                                    label-cols-sm="4"
                                    label-for="column"
                                    slot-scope="{ valid, errors }"
                                    >
                                    <template v-slot:label>
                                    {{ $t('dynamic_form.column') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                        plain
                                        v-model="item.column"
                                        :options="item.colList"
                                        id="form_id"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        >
                                        <template v-slot:first>
                                        <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                        </template>
                                    </b-form-select>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="4" sm="4" md="4" v-if="item.field_type === 'static'">
                                <div style="width:300px,height:300px">
                                    <croppa v-model="croppa"
                                        :width="140"
                                        :height="80"
                                        canvas-color="transparent"
                                        @move="imageChanged(item)"
                                        @new-image-drawn="imageChanged(item)"
                                        accept=".jpeg,.jpg,.png">
                                    </croppa>
                                </div>
                            </b-col>
                        </b-row>
                    </b-overlay>
                    <b-overlay>
                        <b-row v-if="item.type === 'Date'" class="border p-2" style="background-color:#ddd;">
                            <h3 class="mb-2">{{ item.type }}</h3>
                            <b-col lg="12" sm="12" md="12">
                                <ValidationProvider name="Date Type" vid="field_type" rules="required">
                                    <b-form-group
                                        class="row"
                                        label-cols-sm="3"
                                        label-for="field_type"
                                        slot-scope="{ valid, errors }"
                                    >
                                        <template v-slot:label>
                                            {{$t('component_settings.date_type')}}<span class="text-danger">*</span>
                                        </template>
                                        <b-form-select
                                        plain
                                        v-model="item.field_type"
                                        id="field_type"
                                        :options="fieldTypeList"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        >
                                        </b-form-select>
                                            <div class="invalid-feedback">
                                        {{ errors[0] }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="12" sm="12" md="12" v-if="item.field_type === 'dynamic'">
                                <ValidationProvider name="Column" vid="column" rules="required">
                                    <b-form-group
                                        class="row"
                                        label-cols-sm="3"
                                        label-for="column"
                                        slot-scope="{ valid, errors }"
                                    >
                                        <template v-slot:label>
                                            {{$t('dynamic_form.column')}}<span class="text-danger">*</span>
                                        </template>
                                        <b-form-select
                                        plain
                                        v-model="item.column"
                                        id="column"
                                        :options="dateTypeList"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        >
                                        </b-form-select>
                                            <div class="invalid-feedback">
                                        {{ errors[0] }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="12" sm="12" md="12" v-if="item.field_type === 'static'">
                                <ValidationProvider name="Date" vid="value" rules="required">
                                    <b-form-group
                                        class="row"
                                        label-cols-sm="3"
                                        label-for="value"
                                        slot-scope="{ valid, errors }"
                                    >
                                        <template v-slot:label>
                                            {{$t('component_settings.value')}}<span class="text-danger">*</span>
                                        </template>
                                        <flat-pickr class="form-control datepicker"
                                            v-model="item.value"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></flat-pickr>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                        </b-row>
                    </b-overlay>
                </div>
            </b-col>
            <b-col class="ml-4" lg="6" sm="6" md="6">
                <ValidationProvider name="Align" vid="align" rules="required">
                    <b-form-group
                    class="row"
                    label-cols-sm="4"
                    label-for="align"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                    {{ $t('component_settings.alignment') }} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                        plain
                        v-model="align"
                        :options="alignlist"
                        id="align"
                        :state="errors[0] ? false : (valid ? true : null)"
                        >
                        <template v-slot:first>
                        <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                    </b-form-select>
                    <div class="invalid-feedback">
                        {{ errors[0] }}
                    </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
        </b-row>
        <b-col md="12" sm="12" lg="12" class="text-right mt-4">
            <b-button type="submit" @click="saveSettings" variant="primary" class="mr-2">{{ $t('globalTrans.add') }}</b-button>
            &nbsp;
            <b-button variant="danger" class="mr-1" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
        </b-col>
    </b-row>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { dynamicFormEditData } from '../../../../api/routes'
import { snakeToWords } from '@/utils/fliter'
import Croppa from 'vue-croppa'
export default {
    props: ['editData', 'formList'],
    components: {
        croppa: Croppa.component
    },
    data () {
        return {
            qrFields: {
                generate_id: false,
                expire_date: false
            },
            croppa: {},
            loading: false,
            tmpColList: [],
            inputData: [],
            align: 'left',
            inputTypes: [
                { value: 'h1', text_en: 'H1', text_bn: 'এইচ ওয়ান' },
                { value: 'h2', text_en: 'H2', text_bn: 'এইচ টু' },
                { value: 'h3', text_en: 'H3', text_bn: 'এইচ থ্রিরি' },
                { value: 'h4', text_en: 'H4', text_bn: 'এইচ ফোর' },
                { value: 'h5', text_en: 'H5', text_bn: 'এইচ ফাইব' },
                { value: 'h6', text_en: 'H6', text_bn: 'এইচ সিক্স' }
            ],
            fieldTypes: [
                { value: 'static', text_en: 'Static', text_bn: 'স্ট্যাটিক' },
                { value: 'dynamic', text_en: 'Dynamic', text_bn: 'ডাইনামিক' }
            ],
            alignTypes: [
                { value: 'center', text_en: 'Center', text_bn: 'মধ্যম' },
                { value: 'left', text_en: 'Left', text_bn: 'বাম' },
                { value: 'right', text_en: 'Right', text_bn: 'ডান' }
            ],
            dateTypes: [
                { value: 'issue_date', text_en: 'Issue Date', text_bn: 'প্রদানের তারিখ' },
                { value: 'expire_date', text_en: 'Expire Date', text_bn: 'মেয়াদ উত্তীর্ণের তারিখ' }
            ]
        }
    },
    created () {
        if (this.editData) {
            this.inputData = this.editData.map(item => {
                return Object.assign({}, item, { formId: '', tabName: '', column: '', columnBn: '', columnId: '', columnBId: '', tabList: [], colList: [], tmpcolList: [] })
            })
        }
    },
    computed: {
        componentList: function () {
            return [
                { dataType: 'InputField', text: 'Input Field', icon: 'fa fa-pen' },
                { dataType: 'Attachment', text: 'Image', icon: 'fas fa-image' },
                { dataType: 'Paragraph', text: 'Paragraph', icon: 'fa fa-paragraph' },
                { dataType: 'Date', text: 'Date', icon: 'fa fa-calendar' },
                { dataType: 'Header', text: 'Header', icon: 'fa fa-calendar' },
                { dataType: 'Table', text: 'Table', icon: 'fa fa-table' },
                { dataType: 'QR', text: 'QR', icon: 'fa fa-qrcode' },
                { dataType: 'Empty', text: 'Empty', icon: 'fa fa-border-all' },
                { dataType: 'DocumentID', text: 'Document Id', icon: 'fa fa-key' },
                { dataType: 'FirstIssueDate', text: 'First Issue Date', icon: 'fa fa-key' }
            ]
        },
        inputTypeList: function () {
            return this.inputTypes.map(item => {
                if (this.$i18n.locale === 'bn') {
                    return Object.assign(item, { text: item.text_bn, value: item.value })
                } else {
                    return Object.assign(item, { text: item.text_en, value: item.value })
                }
            })
        },
        dateTypeList: function () {
            return this.dateTypes.map(item => {
                if (this.$i18n.locale === 'bn') {
                    return Object.assign(item, { text: item.text_bn, value: item.value })
                } else {
                    return Object.assign(item, { text: item.text_en, value: item.value })
                }
            })
        },
        fieldTypeList: function () {
            return this.fieldTypes.map(item => {
                if (this.$i18n.locale === 'bn') {
                    return Object.assign(item, { text: item.text_bn, value: item.value })
                } else {
                    return Object.assign(item, { text: item.text_en, value: item.value })
                }
            })
        },
        alignlist: function () {
            return this.alignTypes.map(item => {
                if (this.$i18n.locale === 'bn') {
                    return Object.assign(item, { text: item.text_bn, value: item.value })
                } else {
                    return Object.assign(item, { text: item.text_en, value: item.value })
                }
            })
        }
    },
    methods: {
        getTabs (item) {
            item.tabList = []
            item.tmpcolList = []
            item.colList = []
            this.loading = true
            item.stepId = this.getStepId(item.formId)
            RestApi.getData(licenseRegistrationServiceBaseUrl, dynamicFormEditData + '/' + item.formId).then(response => {
                if (response.success) {
                    response.data.tabs.forEach(tab => {
                        const tabObj = { value: tab.tab_name, text: snakeToWords(tab.tab_name) }
                        item.tabList.push(tabObj)
                        tab.layouts.forEach(i => {
                            const input = JSON.parse(i.data)
                            if (input.field_type === 'text' || input.field_type === 'number' || input.field_type === 'options' || input.field_type === 'dropdown' || input.field_type === 'text_area' || input.field_type === 'text' || input.field_type === 'email' || input.field_type === 'date' || input.field_type === 'image' || input.field_type === 'payment' || input.field_type === 'paymentCheckbox') {
                                item.tmpcolList.push({ value: input.field_name, text: input.label, tabName: tab.tab_name, colId: i.id })
                            }
                        })
                    })
                }
                this.loading = false
            })
        },
        setGenId (item) {
            if (this.qrFields.generate_id === true) {
                item.column.push({ text: 'Document Id', label: 'Document Id', value: 'generate_id' })
            }
        },
        setExp (item) {
            if (this.qrFields.expire_date === true) {
                item.column.push({ text: 'Expire Date', label: 'Expire Date', value: 'expire_date' })
            }
        },
        getCols (item) {
            item.colList = []
            item.tmpcolList.map(tmpCol => {
                if (item.tabName === tmpCol.tabName) {
                    item.colList.push({ value: tmpCol.value, text: tmpCol.text, label: tmpCol.text })
                }
            })
        },
        getColId (item) {
            const column = item.tmpcolList.find(i => i.value === item.column)
            item.columnId = column.colId
        },
        getColBId (item) {
            const column = item.tmpcolList.find(i => i.value === item.columnBn)
            item.columnBId = column.colId
        },
        getStepId (formId) {
            const form = this.$store.state.LicenseRegistrationService.commonObj.serviceStepForm.find(form => form.form_id === formId)
            return form.step_id
        },
        addItem (dataType) {
            const item = {}
            if (dataType === 'DocumentID') {
                item.type = dataType
                item.value = ''
                item.value_bn = ''
                item.value_en = ''
                item.formId = ''
                item.tabName = ''
                item.stepId = ''
                item.column = 'generate_id'
                item.columnBn = 'generate_id'
                item.columnId = ''
                item.columnBId = ''
                item.field_type = ''
                item.color = ''
                item.is_bold = ''
                item.tabList = []
                item.colList = []
                item.tmpcolList = []
            } else if (dataType === 'FirstIssueDate') {
                item.type = dataType
                item.value = ''
                item.value_bn = ''
                item.value_en = ''
                item.formId = ''
                item.tabName = ''
                item.stepId = ''
                item.column = 'first_issue_date'
                item.columnBn = 'first_issue_date'
                item.columnId = ''
                item.columnBId = ''
                item.field_type = ''
                item.color = ''
                item.is_bold = ''
                item.tabList = []
                item.colList = []
                item.tmpcolList = []
            } else {
                item.type = dataType
                item.value = ''
                item.value_bn = ''
                item.value_en = ''
                item.formId = ''
                item.tabName = ''
                item.stepId = ''
                item.column = ''
                item.columnBn = ''
                item.columnId = ''
                item.columnBId = ''
                item.field_type = ''
                item.color = ''
                item.is_bold = ''
                item.tabList = []
                item.colList = []
                item.tmpcolList = []
            }
            this.inputData.push(item)
        },
        imageChanged: function (item) {
            item.value = this.croppa.generateDataUrl()
        },
        saveSettings () {
            const inputDataArray = []
            this.inputData.map(item => {
                const data = {
                    type: item.type,
                    value_bn: item.value_bn,
                    value_en: item.value_en,
                    value: item.value,
                    tabName: item.tabName,
                    stepId: item.stepId,
                    column: item.column,
                    columnBn: item.columnBn,
                    columnId: item.columnId,
                    columnBId: item.columnBId,
                    field_type: item.field_type,
                    color: item.color,
                    is_bold: item.is_bold,
                    align: this.align
                }
                inputDataArray.push(data)
            })
            this.$emit('addColumnData', inputDataArray, 'modal-form')
        }
    }
}
</script>
