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
                <h3 style="text-align:center; color: #99513F; margin-top: 1rem; padding: 1rem;">BANGLADESH TEA RESEARCH INSTITUTE</h3>
                <div style="text-align:center;">
                    <p>(Research Organ of Bangladesh Tea Board)</p>
                    <p>Srimangal-3210, Moulvibazar</p>
                    <p>www.btri.gov.bd</p>
                </div>
                <h5 style="margin: 2rem 0; text-align:center; font-style: oblique;">This is to certify that</h5>
                <h5 style="text-align:center;">Mr. Muhammad Abid Hasan Chowdhury</h5>
                <p style="text-align:center; font-style: oblique; font-weight: bold;">Scientific Officer (Biochemistry) of Bangladesh Tea Research Institute</p>
                <p style="text-align:center; font-style: oblique;">
                    has participated in the 56th BTRI Annual Course Held at BTRI, Srimangal, Mouluvibazar from 05 to 10 February 2022.
                </p>
                <div style="margin-top: 2rem;">
                    <strong>This course covered the following subjects:</strong>
                    <ul class="course_subjects" style="margin-top:1rem; list-style:inside;">
                        <li>Tea Soil Management</li>
                        <li>Plant Improvement, Planting Materials and Tea Tasting</li>
                        <li>Nursery Management</li>
                        <li>Crop Management</li>
                        <li>Tea Entomology</li>
                        <li>Tea Plant Pathology</li>
                        <li>Tea Biochemistry</li>
                        <li>Tea Processing</li>
                        <li>Tea Statistics and Economics</li>
                    </ul>
                </div>
                <table style="width: 100%; margin-top: 2rem;">
                    <tbody>
                        <tr>
                            <td></td>
                            <td></td>
                            <td style="text-align: right; vertical-align: top;">
                            <div style="width:100%; display: flex; flex-direction: column;">
                                <img src="../../../../../assets/images/signature.png" style="    margin-left: auto; display: block;" width="80px">
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
    padding: .5in;
    margin: 0 auto;
    margin-bottom: 0.5cm;
}

.page[size="A4"] {
    width: 21cm;
    height: 29.7cm;
}
.paper{
    position: relative;
    width: 100%;
    height: 100%;
    padding: 5px;
    border: 2px solid #b78846;
    background: #fffdfb;
}
.paper-inner{
    position: relative;
    width: 100%;
    height: 100%;
    padding: 1rem;
    border: 2px solid #b78846;
}
.paper::before, .paper::after{
    content: "•";
    position: absolute;
    width: 14px;
    height: 14px;
    font-size: 14px;
    color: #b78846;
    border: 2px solid #b78846;
    line-height: 12px;
    top: 5px;
    text-align: center;
}
.paper::before{
    left: 5px;
}
.paper::after{
    right: 5px;
}
.paper-inner::before,
.paper-inner::after {
    content: "•";
    position: absolute;
    width: 14px;
    height: 14px;
    font-size: 14px;
    color: #b78846;
    border: 2px solid #b78846;
    line-height: 12px;
    bottom: -2px;
    text-align: center;
}
.paper-inner::before {
    left: -2px;
}
.paper-inner::after {
    right: -2px;
}
.course_subjects li{
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
