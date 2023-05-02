<template>
    <main id="fees">
        <div class="fees-body">
            <div class="box p-2">
                <p>To apply for Name Clearance, Registration, Certified Copies and to submit returns, fees and stamps are to be provided
                    as
                    under:</p>
                <strong>Fees of Name Clearance</strong>
                <ul class="basic-list">
                    <li>For NC clearance: @ BDT 200.00 for each of the proposed names.</li>
                    <li>For time extension: @ BDT 200.00 for each time extension application.</li>
                </ul>
                <strong class="py-2">Stamps and Fees of Registration</strong>
                <p>PRIVATE COMPANY (Companies Act, 1994)</p>
                <ul class="basic-list">
                    <li>For affixing on the Memorandum of Association: BDT 1,000.00</li>
                    <li><strong class="font-italic">for affixing on the Articles of Association:</strong></li>
                </ul>
                <div class="table-wrapper">
                    <table class="fl-table">
                        <thead>
                            <tr>
                                <th>Authorized Capital</th>
                                <th>Stamp (BDT)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Up to 10,00,000.00</td>
                                <td>2,000.00</td>
                            </tr>
                            <tr>
                                <td>10,00,000.00 up to 3,00,00,000.00</td>
                                <td>4,000.00</td>
                            </tr>
                            <tr>
                                <td>3,00,00,000.00</td>
                                <td>10,000.00</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <strong class="py-2">Registration fee</strong>
                <ul class="basic-list">
                    <li>For filing 6 documents (5 filled in forms plus 1 memorandum & articles of association, @ BDT 200.00 per document): BDT
                    1,200.00</li>
                    <li>
                        <strong class="font-italic">For the authorized share capital:</strong>
                    </li>
                    <table class="fl-table">
                        <thead>
                            <tr>
                                <th>Authorized Capital (BDT)</th>
                                <th>Fee (BDT)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Up to 20,000.00</td>
                                <td>0.00</td>
                            </tr>
                            <tr>
                                <td>Additional for every 10,000.00 or part after first 20,000.00 up to 50,000.00</td>
                                <td>0.00</td>
                            </tr>
                            <tr>
                                <td>Additional for every 10,000.00 or part after first 50,000.00 up to 10,00,000.00</td>
                                <td>0.00</td>
                            </tr>
                            <tr>
                                <td>Additional for every 1,00,000.00 or part after first 10,00,000.00 up to 50,00,000.00</td>
                                <td>50.00</td>
                            </tr>
                            <tr>
                                <td>Additional for every 1,00,000.00 or part after first 50,00,000.00</td>
                                <td>80.00</td>
                            </tr>
                        </tbody>
                    </table>
                </ul>
            </div>
        </div>
    </main>
</template>
<script>
export default {
    name: 'rjscFees',
    components: {
    }
}
</script>
<style scoped>
.fl-table thead th{
    background: var(--info);
}
</style>
