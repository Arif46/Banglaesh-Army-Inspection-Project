<template>
    <div class="section-wrapper">
        <breadcumb />
        <div class="form-wrapper clone-wrapper">
            <b-card class="total-clone" title="Clone/Bi-Clone Management">
                <b-row no-gutters>
                    <b-col>
                        <div class="clone-card">
                            <div class="content">
                                <div>
                                    <p>Total Clone</p>
                                    <h3>23</h3>
                                </div>
                                <img src="../../../../../assets/images/clone.png" class="img-fluid" alt="">
                            </div>
                            <div class="clone-types">
                                <marquee>
                                    <ul>
                                        <li><a href="#">Clone 1</a></li>
                                        <li><a href="#">Clone 2</a></li>
                                        <li><a href="#">Clone 3</a></li>
                                        <li><a href="#">Clone 4</a></li>
                                        <li><a href="#">Clone 5</a></li>
                                        <li><a href="#">Clone 6</a></li>
                                        <li><a href="#">Clone 7</a></li>
                                        <li><a href="#">Clone 8</a></li>
                                        <li><a href="#">Clone 9</a></li>
                                        <li><a href="#">Clone 10</a></li>
                                        <li><a href="#">Clone 11</a></li>
                                        <li><a href="#">Clone 12</a></li>
                                        <li><a href="#">Clone 13</a></li>
                                        <li><a href="#">Clone 14</a></li>
                                        <li><a href="#">Clone 15</a></li>
                                    </ul>
                                </marquee>
                            </div>
                        </div>
                    </b-col>
                </b-row>
            </b-card>
        </div>
    </div>
</template>
<style>
.clone-wrapper .clone-card {
    color: aliceblue;
    padding: 1rem;
    background: linear-gradient(90deg, rgb(27 44 64) 0%, rgb(21 93 155) 100%);
}

.clone-wrapper .clone-card .content {
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.clone-wrapper .clone-card .content p{
    font-size: 28px;
}
.clone-wrapper .card .card-body .card-title{
    color: #fff!important;
    background-color: #15263a!important;
}
.clone-wrapper .clone-card img{
    height: 100px;
}
.clone-wrapper .clone-types{
    padding: 0.2rem 1rem;
    border-radius: 50px;
    box-shadow: rgb(19 113 255 / 36%) 0px 30px 60px -12px inset, rgb(255 255 255 / 60%) 0px 18px 36px -18px inset;
}
.clone-wrapper .clone-types ul{
    display: flex;
    align-items: center;
    height: 30px;
}
.clone-wrapper .clone-types ul li{
    margin: 0 10px;
}
.clone-wrapper .clone-types ul li a{
    color: #fff;
}
</style>
