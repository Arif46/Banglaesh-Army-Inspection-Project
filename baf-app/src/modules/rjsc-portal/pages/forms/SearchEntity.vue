<template>
    <main id="searchEntity">
        <div class="search-entity">
            <div class="box pt-5 pb-3 px-3">
                <b-row>
                    <b-col sm="4">
                        <b-form>
                            <label for="inline-form-input-name" class="rjsc-form">Entity Type</label>
                            <b-form-select id="inline-form-custom-select-pref" class="mb-2 mr-sm-2 mb-sm-0"
                                :options="[{ text: 'Choose...', value: null }, 'One', 'Two', 'Three']" :value="null"></b-form-select>
                        </b-form>
                    </b-col>
                    <b-col sm="4">
                        <b-form>
                            <label for="inline-form-input-name" class="rjsc-form">Choose language</label>
                            <b-form-select id="inline-form-custom-select-pref" class="mb-2 mr-sm-2 mb-sm-0"
                                :options="[{ text: 'Choose...', value: null }, 'One', 'Two', 'Three']" :value="null"></b-form-select>
                        </b-form>
                    </b-col>
                    <b-col sm="4">
                        <b-form>
                            <label for="inline-form-input-name" class="rjsc-form">Entity Name</label>
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
                            <button class="w-100 btn btn-info">Search</button>
                        </b-form>
                    </b-col>
                </b-row>
            </div>
            <div class="box mt-3">
                <div class="table-wrapper">
                    <h5 class="pb-2">Search Result</h5>
                    <table class="fl-table">
                        <thead>
                            <tr>
                                <th>S/N</th>
                                <th>Entry Name</th>
                                <th>Entry Type</th>
                                <th>Name Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>01</td>
                                <td>Feni</td>
                                <td>Bagerhat</td>
                                <td>Bogra</td>
                            </tr>
                            <tr>
                                <td>02</td>
                                <td>Khagrachhari</td>
                                <td>Chuadanga</td>
                                <td>Dinajpur</td>
                            </tr>
                            <tr>
                                <td>03</td>
                                <td>Bandarban</td>
                                <td>Kushtia</td>
                                <td>Lalmonirhat</td>
                            </tr>
                            <tr>
                                <td>04</td>
                                <td>Brahmanbaria</td>
                                <td>Magura</td>
                                <td>Naogaon</td>
                            </tr>
                            <tr>
                                <td>05</td>
                                <td>Chandpur</td>
                                <td>Meherpur</td>
                                <td>Natore</td>
                            </tr>
                            <tr>
                                <td>06</td>
                                <td>Chittagong</td>
                                <td>Narail</td>
                                <td>Nawabganj</td>
                            </tr>
                            <tr>
                                <td>07</td>
                                <td>Comilla</td>
                                <td>Satkhira</td>
                                <td>Nilphamari</td>
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
    name: 'searchEntity',
    components: {
    }
}
</script>
<style scoped>
.search-entity label.rjsc-form{
    position: absolute;
    top: -10px;
    left: 24px;
    padding: 2px 5px;
    border-radius: 2px;
    color: #fff;
    background: var(--info);
    font-size: 0.7rem;
}
.search-entity .custom-select, .form-control{
    border: 1px solid var(--info);
    padding-top: 12px;
    height: 40px;
    background: #f2f7ff;
}
</style>
