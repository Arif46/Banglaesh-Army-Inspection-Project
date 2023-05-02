<template>
    <main id="submissionStatus">
        <div class="submission-status">
            <div class="box pt-5 pb-3 px-3">
                <b-row>
                    <b-col sm="9">
                        <b-form>
                            <label for="inline-form-input-name" class="rjsc-form">Enter Submission No.</label>
                            <b-form-input id="inline-form-input-name" class="mb-2 mr-sm-2 mb-sm-0" placeholder="Submission No.">
                            </b-form-input>
                        </b-form>
                    </b-col>
                    <b-col sm="3">
                        <b-form>
                            <button class="w-100 btn btn-info">View</button>
                        </b-form>
                    </b-col>
                </b-row>
            </div>
            <div class="box mt-2 p-2">
                <div class="fee-table">
                    <h5 class="pb-3">Submission Status</h5>
                    <table class="">
                        <tbody>
                            <tr>
                                <td>Step Wise Tracking Status</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Submission No.</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Entity Type</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Entity Name</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Submission for</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Submission Status</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>RJSC Office</td>
                                <td></td>
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
    name: 'submissionStatus',
    components: {
    }
}
</script>
<style scoped>
.submission-status label.rjsc-form {
    position: absolute;
    top: -10px;
    left: 24px;
    padding: 2px 5px;
    border-radius: 2px;
    color: #fff;
    background: var(--info);
    font-size: 0.7rem;
}
.submission-status .custom-select,
.form-control {
    border: 1px solid var(--info);
    padding-top: 12px;
    height: 40px;
    background: #f2f7ff;
}
.submission-status .fee-table table tr:nth-child(odd) {
    background: #f2f7ff;
}
.submission-status .fee-table table {
    width: -webkit-fill-available;
}
.submission-status .fee-table table tr td {
    padding: 4px;
    margin-left: 10px;
    width: 50%;
}
</style>
