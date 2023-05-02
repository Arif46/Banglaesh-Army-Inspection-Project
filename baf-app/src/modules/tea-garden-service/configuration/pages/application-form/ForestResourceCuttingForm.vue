<template>
    <div class="section-wrapper">
        <breadcumb />
        <div class="form-wrapper application-form-wrapper">
            <b-card title="Tea Garden Forest Resource Cutting Form">
                <b-card-text>
                    <form-wizard class="garden-forest-resource-cutting-wrapper" shape="circle" title="" subtitle="" :start-index.sync="activeIndex">
                        <tab-content :title="$t('teaGardenConfig.tree_details_Category')" icon="ri-file-cloud-line" :before-change="tabSubmitBasic">
                            <div class="application-itmes">
                                <b-row>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="Tree Class of Forest Resources" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col>
                                                            <b-form-checkbox-group class="custom-control-inline-wrapper" size="lg" v-model="selected" :options="classOfTrees" :aria-describedby="ariaDescribedby" name="" stacked></b-form-checkbox-group>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="Description of Forest Resources" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="12">
                                                            <b-form-group label="Unit Quantity:" v-slot="{ ariaDescribedby }">
                                                                <b-form-radio-group class="custom-control-inline-wrapper mb-0" v-model="selected" size="lg" :options="unitQuantity" :aria-describedby="ariaDescribedby"
                                                                    name="radio-options"></b-form-radio-group>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Plantation Year (if not natural tree):" label-for="PlantationYear">
                                                                <b-form-select id="PlantationYear" v-model="selected" :options="options">
                                                                </b-form-select>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Number of Trees:" label-for="NumberOfTrees">
                                                                <b-form-input type="number" id="NumberOfTrees"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Average Diameter / Size:" label-for="AverageDiameterSize">
                                                                <b-form-input id="AverageDiameterSize"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Quantity (Approx):" label-for="Quantity">
                                                                <b-form-input type="number" id="Quantity"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="Area/Location of Forest Resources" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="6">
                                                            <b-form-group label="Section No:" label-for="SectionNo">
                                                                <b-form-input type="number" id="SectionNo"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Mouja:" label-for="MoujaName">
                                                                <b-form-input id="MoujaName"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Khotian No:" label-for="KhotianNo">
                                                                <b-form-input type="number" id="KhotianNo"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Dag No:" label-for="DagNo">
                                                                <b-form-input type="number" id="DagNo"></b-form-input>
                                                                <small style="text-align: right;display: block;">(Should be supported by <b>8”= 1 mile</b> sketch map)</small>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="12">
                                                            <b-form-group label="Plant Species:" label-for="PlantSpecies">
                                                                <table class="table table-sm">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td>
                                                                                <b-form-group label="Tree Name (En)" label-for="TreeNameEn">
                                                                                    <b-form-input id="TreeNameEn"></b-form-input>
                                                                                </b-form-group>
                                                                            </td>
                                                                            <td>
                                                                                <b-form-group label="Tree Name (Bn)" label-for="TreeNameBn">
                                                                                    <b-form-input id="TreeNameBn"></b-form-input>
                                                                                </b-form-group>
                                                                            </td>
                                                                            <td>
                                                                                <b-form-group label="Number of Tree" label-for="NumberOfTree">
                                                                                    <b-form-input type="number" id="NumberOfTree"></b-form-input>
                                                                                </b-form-group>
                                                                            </td>
                                                                            <td style="width:20%">
                                                                                <button type="button" class="btn add-more-btn btn-secondary btn-sm" style="margin-top: 20px"><i class="ri-add-line"></i> Add More</button>
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                                <table class="table table-sm">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td><b>Mahogany</b></td>
                                                                            <td><b>মেহগনি</b></td>
                                                                            <td>5</td>
                                                                            <td class="text-center">
                                                                                <a href="javascript:" class="text-danger" title="Delete"><i class="ri-delete-bin-6-line"></i></a>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><b>Lebec</b></td>
                                                                            <td><b>লেবেক</b></td>
                                                                            <td>1</td>
                                                                            <td class="text-center">
                                                                                <a href="javascript:" class="text-danger" title="Delete"><i class="ri-delete-bin-6-line"></i></a>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><b>Odrotichima</b></td>
                                                                            <td><b>অডরোটিসিমা</b></td>
                                                                            <td>3</td>
                                                                            <td class="text-center">
                                                                                <a href="javascript:" class="text-danger" title="Delete"><i class="ri-delete-bin-6-line"></i></a>
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="12">
                                                            <b-button class="add-more-btn" size="sm"><i class="ri-add-line"></i> Add More Plant Species</b-button>
                                                        </b-col>
                                                        <b-col sm="12">
                                                            <table class="table table-sm table-bordered section-tree-view-table">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Section No</th>
                                                                        <th class="text-left">Mouja</th>
                                                                        <th>Khotian No</th>
                                                                        <th>Dag No</th>
                                                                        <th>Tree Name</th>
                                                                        <th>Number of Tree</th>
                                                                        <th>Action</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <td>1</td>
                                                                        <td class="text-left">Lot 71/A Udalia</td>
                                                                        <td>3</td>
                                                                        <td>894</td>
                                                                        <td class="p-0">
                                                                            <table class="table table-sm m-0">
                                                                                <tr>
                                                                                    <td>Mahogany</td>
                                                                                    <td>মেহগনি</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>Lebec</td>
                                                                                    <td>লেবেক</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>Odrotichima</td>
                                                                                    <td>অডরোটিসিমা</td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                        <td class="p-0">
                                                                            <table class="table table-sm m-0">
                                                                                <tr>
                                                                                    <td>5</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>1</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>3</td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                        <td class="text-center" style="border-bottom-color: transparent">
                                                                            <a href="javascript:" class="text-danger" title="Delete"><i class="ri-delete-bin-6-line"></i></a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="5" class="text-right">
                                                                            <b>Sub Total</b>
                                                                        </td>
                                                                        <td>
                                                                            <b>9</b>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>2</td>
                                                                        <td class="text-left">Lot 71/A Udalia</td>
                                                                        <td>3</td>
                                                                        <td>894</td>
                                                                        <td class="p-0">
                                                                            <table class="table table-sm m-0">
                                                                                <tr>
                                                                                    <td>Mahogany</td>
                                                                                    <td>মেহগনি</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>Lebec</td>
                                                                                    <td>লেবেক</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>Odrotichima</td>
                                                                                    <td>অডরোটিসিমা</td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                        <td class="p-0">
                                                                            <table class="table table-sm m-0">
                                                                                <tr>
                                                                                    <td>5</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>1</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>3</td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                        <td class="text-center" style="border-bottom-color: transparent">
                                                                            <a href="javascript:" class="text-danger" title="Delete"><i class="ri-delete-bin-6-line"></i></a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="5" class="text-right">
                                                                            <b>Sub Total</b>
                                                                        </td>
                                                                        <td>
                                                                            <b>9</b>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="5" class="text-right">
                                                                            <b>Grand Total</b>
                                                                        </td>
                                                                        <td>
                                                                            <b>18</b>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="7" class="text-right pe-5">
                                                                            <b>(Total Eighteen Trees)</b>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                </b-row>
                            </div>
                        </tab-content>
                        <tab-content :title="$t('teaGardenConfig.purpose_tree_cutting')" icon="ri-contacts-line">
                            <div class="application-itmes">
                                <b-row>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="Purpose of Tree Felling" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col>
                                                            <b-form-checkbox-group class="custom-control-inline-wrapper" size="lg" v-model="selected" :options="whatKindTrees" :aria-describedby="ariaDescribedby" name="" stacked>
                                                            </b-form-checkbox-group>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="How many types of trees will be cut?" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="6">
                                                            <b-form-group label="Total Cutable Trees:" label-for="TotalCutableTrees">
                                                                <b-form-input type="number" id="TotalCutableTrees"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Number of Re-plantable Trees:" label-for="NoOfReplantableTrees">
                                                                <b-form-input type="number" id="NoOfReplantableTrees"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Number of Very Old Trees:" label-for="NoOfVeryOldTrees">
                                                                <b-form-input type="number" id="NoOfVeryOldTrees"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Number of Rubber Trees:" label-for="NoOfRubberTrees">
                                                                <b-form-input type="number" id="NoOfRubberTrees"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Number of Diseased Trees:" label-for="NoOfDiseasedTrees">
                                                                <b-form-input type="number" id="NoOfDiseasedTrees"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Number of Other Trees:" label-for="NoOfOtherTrees">
                                                                <b-form-input type="number" id="NoOfOtherTrees"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                </b-row>
                            </div>
                        </tab-content>
                        <tab-content :title="$t('teaGardenConfig.previous_permission_story')" icon="ri-play-list-add-line">
                            <div class="application-itmes">
                                <b-row>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="Tea Board's Memorial Number" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="4">
                                                            <b-form-group label="Memorial Number:" label-for="MemorialNo">
                                                                <b-form-input type="number" id="MemorialNo"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="4">
                                                            <b-form-group label="Date:" label-for="Date">
                                                                <b-form-datepicker id="Date" v-model="value" class="mb-2"></b-form-datepicker>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="4">
                                                            <b-form-group label="Attachment:" label-for="Attachment">
                                                                <b-form-file id="Attachment"></b-form-file>
                                                            </b-form-group>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="Types of Forest Trees Felled" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col>
                                                            <b-form-checkbox-group class="custom-control-inline-wrapper" size="lg" v-model="selected"
                                                                :options="classOfTrees" :aria-describedby="ariaDescribedby" name="" stacked>
                                                            </b-form-checkbox-group>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="Description of Forest Resources" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="12">
                                                            <b-form-group label="Unit Quantity:" v-slot="{ ariaDescribedby }">
                                                                <b-form-radio-group class="custom-control-inline-wrapper" v-model="selected" size="lg" :options="unitQuantity"
                                                                    :aria-describedby="ariaDescribedby" name="radio-options"></b-form-radio-group>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Plantation Year (if not natural tree):" label-for="PlantationYear">
                                                                <b-form-select id="PlantationYear" v-model="selected" :options="options">
                                                                </b-form-select>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Number of Trees:" label-for="NumberOfTrees">
                                                                <b-form-input type="number" id="NumberOfTrees"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Average Diameter / Size:" label-for="AverageDiameterSize">
                                                                <b-form-input id="AverageDiameterSize"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Quantity (Approx):" label-for="Quantity">
                                                                <b-form-input type="number" id="Quantity"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="Area/Location of Forest Resources" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="6">
                                                            <b-form-group label="Section No:" label-for="SectionNo">
                                                                <b-form-input type="number" id="SectionNo"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Mouja:" label-for="MoujaName">
                                                                <b-form-input id="MoujaName"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Khotian No:" label-for="KhotianNo">
                                                                <b-form-input type="number" id="KhotianNo"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Dag No:" label-for="DagNo">
                                                                <b-form-input type="number" id="DagNo"></b-form-input>
                                                                <small style="text-align: right;display: block;">(Should be supported by <b>8”= 1 mile</b>
                                                                    sketch map)</small>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="12">
                                                            <b-form-group label="Plant Species:" label-for="PlantSpecies">
                                                                <table class="table table-sm">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td>
                                                                                <b-form-group label="Tree Name (En)" label-for="PlantSpeciesTreeNameEn">
                                                                                    <b-form-input id="PlantSpeciesTreeNameEn"></b-form-input>
                                                                                </b-form-group>
                                                                            </td>
                                                                            <td>
                                                                                <b-form-group label="Tree Name (Bn)" label-for="PlantSpeciesTreeNameBn">
                                                                                    <b-form-input id="PlantSpeciesTreeNameBn"></b-form-input>
                                                                                </b-form-group>
                                                                            </td>
                                                                            <td>
                                                                                <b-form-group label="Number of Tree" label-for="PlantSpeciesNumberOfTree">
                                                                                    <b-form-input type="number" id="PlantSpeciesNumberOfTree"></b-form-input>
                                                                                </b-form-group>
                                                                            </td>
                                                                            <td style="width:20%">
                                                                                <button type="button" class="btn add-more-btn btn-secondary btn-sm" style="margin-top: 20px"><i class="ri-add-line"></i> Add More</button>
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                                <table class="table table-sm">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td><b>Mahogany</b></td>
                                                                            <td><b>মেহগনি</b></td>
                                                                            <td>5</td>
                                                                            <td class="text-center">
                                                                                <a href="javascript:" class="text-danger" title="Delete"><i
                                                                                        class="ri-delete-bin-6-line"></i></a>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><b>Lebec</b></td>
                                                                            <td><b>লেবেক</b></td>
                                                                            <td>1</td>
                                                                            <td class="text-center">
                                                                                <a href="javascript:" class="text-danger" title="Delete"><i
                                                                                        class="ri-delete-bin-6-line"></i></a>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><b>Odrotichima</b></td>
                                                                            <td><b>অডরোটিসিমা</b></td>
                                                                            <td>3</td>
                                                                            <td class="text-center">
                                                                                <a href="javascript:" class="text-danger" title="Delete"><i
                                                                                        class="ri-delete-bin-6-line"></i></a>
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="12">
                                                            <b-button class="add-more-btn" size="sm"><i class="ri-add-line"></i> Add More Plant Species
                                                            </b-button>
                                                        </b-col>
                                                        <b-col sm="12">
                                                            <table class="table table-sm table-bordered section-tree-view-table">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Section No</th>
                                                                        <th class="text-left">Mouja</th>
                                                                        <th>Khotian No</th>
                                                                        <th>Dag No</th>
                                                                        <th>Tree Name</th>
                                                                        <th>Number of Tree</th>
                                                                        <th>Action</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <td>1</td>
                                                                        <td class="text-left">Lot 71/A Udalia</td>
                                                                        <td>3</td>
                                                                        <td>894</td>
                                                                        <td class="p-0">
                                                                            <table class="table table-sm m-0">
                                                                                <tr>
                                                                                    <td>Mahogany</td>
                                                                                    <td>মেহগনি</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>Lebec</td>
                                                                                    <td>লেবেক</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>Odrotichima</td>
                                                                                    <td>অডরোটিসিমা</td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                        <td class="p-0">
                                                                            <table class="table table-sm m-0">
                                                                                <tr>
                                                                                    <td>5</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>1</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>3</td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                        <td class="text-center" style="border-bottom-color: transparent">
                                                                            <a href="javascript:" class="text-danger" title="Delete"><i
                                                                                    class="ri-delete-bin-6-line"></i></a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="5" class="text-right">
                                                                            <b>Sub Total</b>
                                                                        </td>
                                                                        <td>
                                                                            <b>9</b>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>2</td>
                                                                        <td class="text-left">Lot 71/A Udalia</td>
                                                                        <td>3</td>
                                                                        <td>894</td>
                                                                        <td class="p-0">
                                                                            <table class="table table-sm m-0">
                                                                                <tr>
                                                                                    <td>Mahogany</td>
                                                                                    <td>মেহগনি</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>Lebec</td>
                                                                                    <td>লেবেক</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>Odrotichima</td>
                                                                                    <td>অডরোটিসিমা</td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                        <td class="p-0">
                                                                            <table class="table table-sm m-0">
                                                                                <tr>
                                                                                    <td>5</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>1</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>3</td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                        <td class="text-center" style="border-bottom-color: transparent">
                                                                            <a href="javascript:" class="text-danger" title="Delete"><i
                                                                                    class="ri-delete-bin-6-line"></i></a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="5" class="text-right">
                                                                            <b>Sub Total</b>
                                                                        </td>
                                                                        <td>
                                                                            <b>9</b>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="5" class="text-right">
                                                                            <b>Grand Total</b>
                                                                        </td>
                                                                        <td>
                                                                            <b>18</b>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="7" class="text-right pe-5">
                                                                            <b>(Total Eighteen Trees)</b>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="Purpose/Reason of Previous Tree Felling" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col>
                                                            <b-form-checkbox-group class="custom-control-inline-wrapper" size="lg" v-model="selected"
                                                                :options="whatKindTrees" :aria-describedby="ariaDescribedby" name="" stacked>
                                                            </b-form-checkbox-group>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                </b-row>
                            </div>
                        </tab-content>
                        <tab-content :title="$t('teaGardenConfig.garden_development_planning')" icon="ri-map-pin-2-fill">
                            <div class="application-itmes">
                                <b-row>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="Does the Garden have a development plan? If so, please mention that the plan was approved in which LTC Committee meeting. Also mention the detail of the plantation program" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="6">
                                                            <b-form-group label="Fiscal Year:" label-for="FiscalYear">
                                                                <b-form-select id="FiscalYear" v-model="selected" :options="options"></b-form-select>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Amplification / Replacement Planting (Hectares):" label-for="AmplificationReplacementPlanting">
                                                                <b-form-input id="AmplificationReplacementPlanting"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Re-plantation / Block Infilling (Hectares):" label-for="ReplantationBlockInfilling">
                                                                <b-form-input id="ReplantationBlockInfilling"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Rubber (Hectares):" label-for="Rubber">
                                                                <b-form-input id="Rubber"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Afforestation (Hectares):" label-for="Afforestation">
                                                                <b-form-input id="Afforestation"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Other Plants (Hectares):" label-for="OtherPlants">
                                                                <b-form-input id="OtherPlants"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                </b-row>
                            </div>
                        </tab-content>
                        <tab-content :title="$t('teaGardenConfig.garden_info')" icon="ri-list-settings-line">
                            <div class="application-itmes">
                                <b-row>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="Garden Address" label-size="lg" label-class="font-weight-bold pt-0"
                                                    class="mb-0">
                                                    <b-row>
                                                        <b-col sm="6">
                                                            <b-form-group label="Registration No:" label-for="RegistrationNo">
                                                                <b-form-input id="RegistrationNo"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Tea Garden Name (En):" label-for="TeaGardenNameEn">
                                                                <b-form-input id="TeaGardenNameEn"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Area Type:" label-for="AreaType">
                                                                <b-form-select id="AreaType" v-model="selected" :options="options">
                                                                </b-form-select>
                                                            </b-form-group>
                                                        </b-col>
                                                        <!-- City Corporation Area Type -->
                                                        <b-col sm="6">
                                                            <b-form-group label="Division:" label-for="Division">
                                                                <b-form-select id="Division" v-model="selected" :options="options"></b-form-select>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="District:" label-for="District">
                                                                <b-form-select id="District" v-model="selected" :options="options"></b-form-select>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="City Corporation:" label-for="CityCorporation">
                                                                <b-form-select id="CityCorporation" v-model="selected" :options="options"></b-form-select>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Ward:" label-for="Ward">
                                                                <b-form-select id="Ward" v-model="selected" :options="options"></b-form-select>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Post Code:" label-for="PostCode">
                                                                <b-form-select id="PostCode" v-model="selected" :options="options"></b-form-select>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="12">
                                                            <b-form-group label="Address (En):" label-for="AddressEn">
                                                                <b-form-textarea id="AddressEn" placeholder="Enter something..."></b-form-textarea>
                                                            </b-form-group>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="Identity of Proprietor" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="12">
                                                            <table class="table table-sm table-bordered mb-0">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Company Name</th>
                                                                        <th>Owner’s Name</th>
                                                                        <th>Father’s Name</th>
                                                                        <th>Mother’s Name</th>
                                                                        <th>Nationality</th>
                                                                        <th>Mobile No</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <td>Syntech</td>
                                                                        <td>Md. Tawhiduzzaman</td>
                                                                        <td>Md. Moniruzzaman</td>
                                                                        <td>Mrs. Fatema</td>
                                                                        <td>Bangladeshi</td>
                                                                        <td>01717249225</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Syntech</td>
                                                                        <td>Md. Tawhiduzzaman</td>
                                                                        <td>Md. Moniruzzaman</td>
                                                                        <td>Mrs. Fatema</td>
                                                                        <td>Bangladeshi</td>
                                                                        <td>01717249225</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Syntech</td>
                                                                        <td>Md. Tawhiduzzaman</td>
                                                                        <td>Md. Moniruzzaman</td>
                                                                        <td>Mrs. Fatema</td>
                                                                        <td>Bangladeshi</td>
                                                                        <td>01717249225</td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                </b-row>
                            </div>
                        </tab-content>
                        <template slot="footer" slot-scope="props">
                            <div class="wizard-footer-right">
                                <wizard-button class="btn btn-primary ml-1 mr-1" @click.native="props.prevTab(), step--"
                                    v-if="props.activeTabIndex > 0" style="background: #eee"><i class="ri-arrow-left-line"></i> {{
                                    $t('globalTrans.back') }}</wizard-button>
                                <wizard-button type="submit" style="background:#214162!important;border-color:#214162!important;"
                                    class="btn btn-info ml-1 mr-1" title="Create Draft and Save!" @click.native="props.nextTab(), draft = 1"><i
                                        class="ri-draft-line"></i> {{$t('globalTrans.save_draft')}}
                                </wizard-button>
                                <wizard-button type="submit" v-if="!props.isLastStep" @click.native="props.nextTab(), isNext = true"
                                    class="btn btn-success ml-1 mr-1" title="Draft and go to next!" :style="props.fillButtonStyle"><i
                                        class="ri-save-2-line"></i> {{ $t('globalTrans.draft_n_next') }}
                                </wizard-button>
                                <wizard-button v-else type="submit" style="background:#0ab970!important;border-color:#07b16a!important;"
                                    class="btn btn-success ml-1" title="Submit!" @click.native="finalSave(), app_status = 2"><i
                                        class="ri-send-plane-fill"></i> {{ $t('globalTrans.finalSave')}}
                                </wizard-button>
                            </div>
                        </template>
                    </form-wizard>
                </b-card-text>
            </b-card>
        </div>
    </div>
</template>
<script>
import { FormWizard, TabContent } from 'vue-form-wizard'
import 'vue-form-wizard/dist/vue-form-wizard.min.css'
import WizardButton from 'vue-form-wizard/src/components/WizardButton.vue'
export default {
    components: { FormWizard, TabContent, WizardButton },
    data () {
        return {
            activeIndex: 0,
            selected: [],
            options: [
                { text: 'Something 1', value: 'Something 1' },
                { text: 'Something 2', value: 'Something 2' },
                { text: 'Something 3', value: 'Something 3' },
                { text: 'Something 4', value: 'Something 4' },
                { text: 'Something 5', value: 'Something 5' },
                { text: 'Something 6', value: 'Something 6' }
            ],
            ownerType: [
                { text: 'Owner', value: 'Owner' },
                { text: 'Share holder', value: 'Share holder' },
                { text: 'Directors', value: 'Directors' }
            ],
            classOfTrees: [
                { text: 'Shed Tree', value: 'Shed Tree' },
                { text: 'Planted Tree', value: 'Planted Tree' },
                { text: 'Natural Tree', value: 'Natural Tree' },
                { text: 'Rubber', value: 'Rubber' },
                { text: 'Bamboo', value: 'Bamboo' },
                { text: 'Others', value: 'Others' }
            ],
            possessesFactory: [
                { text: 'Yes', value: 'Yes' },
                { text: 'No', value: 'No' }
            ],
            unitQuantity: [
                { text: 'Cubic Feet', value: 'Cubic Feet' },
                { text: 'Cubic Meter', value: 'Cubic Meter' }
            ],
            whatKindTrees: [
                { text: 'Tea Cultivation Extension', value: 'Tea Cultivation Extension' },
                { text: 'Re-Plantation', value: 'Re-Plantation' },
                { text: 'Very Old Tree', value: 'Very Old Tree' },
                { text: 'Planted Rubber', value: 'Planted Rubber' },
                { text: 'Diseased Tree', value: 'Diseased Tree' },
                { text: 'Others', value: 'Others' }
            ]
        }
    }
}
</script>
