<template>
    <div size="A4" class="page">
        <div class="paper">
            <div class="paper-inner">
                <table style="width: 100%;">
                    <tbody>
                        <tr>
                            <td style="text-align: left; vertical-align: top; width: 33.33%;">
                            </td>
                            <td style="text-align: center; vertical-align: top; width: 33.33%;">
                                <img src="../../../../../assets/images/btb-logo.jpg" width="80px">
                            </td>
                            <td style="text-align: right; vertical-align: top; width: 33.33%;">
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: left; vertical-align: top;">Date: 10:12:2022</td>
                            <td></td>
                            <td style="text-align: right; vertical-align: top;">SL. No. 19/56/909</td>
                        </tr>
                    </tbody>
                </table>
                <h3 style="text-align:center; color: #3aaa35; margin-top: 1rem; padding: 1rem;">BANGLADESH TEA RESEARCH
                    INSTITUTE</h3>
                <div style="text-align:center;">
                    <p>(Research Organ of Bangladesh Tea Board)</p>
                    <p>Srimangal-3210, Moulvibazar</p>
                    <p>www.btri.gov.bd</p>
                </div>
                <h3 style="text-align:center; color: #99513F; margin-top: 1rem; padding: 1rem;">Post Graduate Diploma in Tax Management</h3>
                <h5 style="margin: 1rem 0; text-align:center; font-style: oblique;">This is to certify that</h5>
                <h5 style="text-align:center;">Mr. Muhammad Abid Hasan Chowdhury</h5>
                <p style="text-align:center; font-style: oblique; font-weight: bold;">Scientific Officer (Biochemistry)
                    of Bangladesh Tea Research Institute</p>
                <p style="text-align:center; font-style: oblique;">
                    has participated in the 56th BTRI Annual Course Held at BTRI, Srimangal, Mouluvibazar from 05 to 10
                    February 2022.
                </p>
                <table style="width: 100%; margin-top: 2rem;">
                    <tbody>
                        <tr>
                            <td></td>
                            <td></td>
                            <td style="text-align: right; vertical-align: top;">
                                <div style="width:100%; display: flex; flex-direction: column;">
                                    <img src="../../../../../assets/images/signature.png"
                                        style="    margin-left: auto; display: block;" width="80px">
                                    <strong>(Dr. Muhammad Ali)</strong>
                                    <p>Director, BTRI</p>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</template>
<style scoped>
.page {
    background: #fff;
    padding: .3in;
}

.page[size="A4"] {
    margin: 1rem auto;
    height: 18cm;
    width: 25.4571cm;
}
.paper{
    height: 100%;
    padding: 2rem;
    border-image-slice: 33% 33% 33% 33%;
    border-image-width: 1.3em;
    border-image-outset: 0px 0px 0px 0px;
    border-image-repeat:  round round;
    border-image-source: url("../../../../../assets/images/border2.png");
    border-style: solid;
    background-color: #fff;
    background: repeating-linear-gradient(45deg, #eaffed8a, #eaffed45 4px, #fff 4px, #fff 20px);
}

.course_subjects li {
    padding: .4rem 0;
}

@media print {

    body,
    .page {
        margin: 0;
        box-shadow: 0;
    }
}
</style>
