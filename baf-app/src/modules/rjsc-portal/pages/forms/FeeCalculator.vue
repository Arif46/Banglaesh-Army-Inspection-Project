<template>
    <main id="feeCalculator">
        <div class="fee-calculator">
            <div class="box pt-5 pb-3 px-3">
                <b-row>
                    <b-col sm="4">
                        <b-form>
                            <label for="inline-form-input-name" class="rjsc-form">Business Type</label>
                            <b-form-select id="inline-form-custom-select-pref" class="mb-2 mr-sm-2 mb-sm-0"
                                :options="[{ text: 'Choose...', value: null }, 'One', 'Two', 'Three']" :value="null">
                            </b-form-select>
                        </b-form>
                    </b-col>
                    <b-col sm="4">
                        <b-form>
                            <label for="inline-form-input-name" class="rjsc-form">Entity Type</label>
                            <b-form-select id="inline-form-custom-select-pref" class="mb-2 mr-sm-2 mb-sm-0"
                                :options="[{ text: 'Choose...', value: null }, 'One', 'Two', 'Three']" :value="null">
                            </b-form-select>
                        </b-form>
                    </b-col>
                    <b-col sm="4">
                        <b-form>
                            <label for="inline-form-input-name" class="rjsc-form">Authorized Capital</label>
                            <b-form-input id="inline-form-input-name" class="mb-2 mr-sm-2 mb-sm-0" placeholder="Entity Name">
                            </b-form-input>
                        </b-form>
                    </b-col>
                </b-row>
                <b-row>
                    <b-col sm="9">
                    </b-col>
                    <b-col sm="3">
                        <b-form>
                            <label>&nbsp;</label>
                            <button class="w-100 btn btn-info">View</button>
                        </b-form>
                    </b-col>
                </b-row>
            </div>
            <div class="box p-2 mt-2">
                <div class="fee-table">
                    <h5 class="pb-2">Fee List</h5>
                    <table class="">
                        <tbody>
                            <tr>
                                <td>01</td>
                                <td>Registration fee BDT 10,000.00</td>
                            </tr>
                            <tr>
                                <td>02</td>
                                <td>Registration filing fee BDT 400.00</td>
                            </tr>
                            <tr>
                                <td>03</td>
                                <td>Certified Copy MOA+Digital Certificate: 1120</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
</template>
<script>
export default {
    name: 'feeCalculator',
    components: {
    }
}
</script>
<style scoped>
.fee-calculator label.rjsc-form {
    position: absolute;
    top: -10px;
    left: 24px;
    padding: 2px 5px;
    border-radius: 2px;
    color: #fff;
    background: var(--info);
    font-size: 0.7rem;
}
.fee-calculator .custom-select,
.form-control {
    border: 1px solid var(--info);
    padding-top: 12px;
    height: 40px;
    background: #f2f7ff;
}
.fee-calculator .fee-table table tr:nth-child(odd){
    background: #f2f7ff;
}
.fee-calculator .fee-table table{
    width: -webkit-fill-available;
}
.fee-calculator .fee-table table tr td:nth-child(even){
    width: 90%;
}
.fee-calculator .fee-table table tr td{
    padding: 4px;
    margin-left: 10px;
}
</style>
