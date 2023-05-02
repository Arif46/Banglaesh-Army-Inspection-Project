<template>
    <div class="box p-3 mb-3">
        <div class="section_title mb-3">
            <h4 class="text-center">INDUSTRY EXPERTISE</h4>
        </div>
        <div class="expertise">
            <div class="expertise-item">
                <div class="eprerise-content">
                    <div class="count">23</div>
                    <p class="title">Government/Military-National/State/Local</p>
                </div>
            </div>
            <div class="expertise-item">
                <div class="eprerise-content">
                    <div class="count">23</div>
                    <p class="title">Travel, Hotel & Tourism</p>
                </div>
            </div>
            <div class="expertise-item">
                <div class="eprerise-content">
                    <div class="count">23</div>
                    <p class="title">Outsourcing</p>
                </div>
            </div>
            <div class="expertise-item">
                <div class="eprerise-content">
                    <div class="count">23</div>
                    <p class="title">Banking/Financial</p>
                </div>
            </div>
            <div class="expertise-item">
                <div class="eprerise-content">
                    <div class="count">521</div>
                    <p class="title">Retail/Wholesale/Distribution</p>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'technicalInfo'
    }
</script>
<style>
.expertise:after{
    content: "";
    display: table;
    clear: both;
}
.expertise-item{
    float: left;
    width: 20%;
    padding: 10px;
}
.eprerise-content{
    display: flex;
    flex-direction: column;
    align-items: center;
    min-height: 6rem;
    text-align: center;
    padding: .5rem;
    border-radius: 5px;
    border: 2px dotted var(--rjsc-brand);
    background: rgb(243, 243, 255);
}
.eprerise-content .count{
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 5px;
    width: 30px;
    height: 30px;
    border-radius: 30px;
    text-align: center;
    color: #fff;
    background: var(--rjsc-brand);
}
.eprerise-content .title{
    word-break: break-word;
    font-weight: 600;
}
@media (max-width: 575.98px) {
    .expertise-item {
        float: left;
        width: 100%;
        padding: 10px;
    }
}
</style>
