<template>
    <main>
        <div class="main-search-section">
            <h1>Search Entity Name</h1>
            <div class="search-box">
                <form action="" class="search-box">
                    <div class="search-icon"><i class="ri-search-2-line"></i></div>
                    <input type="text" placeholder="Search" id="search" autocomplete="off">
                </form>
            </div>
            <div class="advance-search">
                <div class="advance-search-options">
                    <div class="latter-shorting">
                        <ul>
                            <li><a href="javascript:void(0)">A</a></li>
                            <li><a href="javascript:void(0)">B</a></li>
                            <li><a href="javascript:void(0)">C</a></li>
                            <li><a href="javascript:void(0)">D</a></li>
                            <li><a href="javascript:void(0)">E</a></li>
                            <li><a href="javascript:void(0)">F</a></li>
                            <li><a href="javascript:void(0)">G</a></li>
                            <li><a href="javascript:void(0)">H</a></li>
                            <li><a href="javascript:void(0)">I</a></li>
                            <li><a href="javascript:void(0)">J</a></li>
                            <li><a href="javascript:void(0)">K</a></li>
                            <li><a href="javascript:void(0)">L</a></li>
                            <li><a href="javascript:void(0)">M</a></li>
                            <li><a href="javascript:void(0)">N</a></li>
                            <li><a href="javascript:void(0)">O</a></li>
                            <li><a href="javascript:void(0)">P</a></li>
                            <li><a href="javascript:void(0)">Q</a></li>
                            <li><a href="javascript:void(0)">R</a></li>
                            <li><a href="javascript:void(0)">S</a></li>
                            <li><a href="javascript:void(0)">T</a></li>
                            <li><a href="javascript:void(0)">U</a></li>
                            <li><a href="javascript:void(0)">V</a></li>
                            <li><a href="javascript:void(0)">W</a></li>
                            <li><a href="javascript:void(0)">X</a></li>
                            <li><a href="javascript:void(0)">Y</a></li>
                            <li><a href="javascript:void(0)">Z</a></li>
                        </ul>
                    </div>
                    <b-row>
                        <b-col sm="3">
                            <b-form>
                                <label for="entity-type">Entity Type</label>
                                <b-form-select id="entity-type" class="mb-2 mr-sm-2 mb-sm-0"
                                    :options="[{ text: 'Choose...', value: null }, 'One', 'Two', 'Three']" :value="null"></b-form-select>
                            </b-form>
                        </b-col>
                        <b-col sm="3">
                            <b-form>
                                <label for="sector">Sector</label>
                                <b-form-select id="sector" class="mb-2 mr-sm-2 mb-sm-0"
                                    :options="[{ text: 'Choose...', value: null }, 'One', 'Two', 'Three']" :value="null"></b-form-select>
                            </b-form>
                        </b-col>
                        <b-col sm="3">
                            <b-form>
                                <label for="entity-name">Entity Name</label>
                                <b-form-input id="entity-name" class="mb-2 mr-sm-2 mb-sm-0" placeholder="Entity Name"></b-form-input>
                            </b-form>
                        </b-col>
                        <b-col sm="3">
                            <b-form>
                                <label>&nbsp;</label>
                                <button class="w-100">Search</button>
                            </b-form>
                        </b-col>
                    </b-row>
                </div>
            </div>
        </div>
        <b-container>
            <div class="entity-list">
                <b-card class="entity-list-item">
                    <b-row>
                        <b-col sm="2">
                            <div class="entity-logo">
                                <img src="../../../assets/images/syntech2.png" alt="">
                            </div>
                        </b-col>
                        <b-col sm="10">
                            <div class="entity-details">
                                <h4>Syntech Solution Ltd.</h4>
                                <small class="text-muted">Establishment: January 2006</small>
                                <p>
                                    Syntech Solution Ltd is CMMI Level 3, ISO 9001 and ISO 27001 certified software engineering and
                                    consultancy firm focused
                                    on Web Based Application, & software development, offshore web design, Website
                                </p>
                            </div>
                        </b-col>
                    </b-row>
                    <div class="entity-view-overlay">
                        <button class="btn" @click="swichToProfile">View Profile</button>
                    </div>
                </b-card>
                <b-card class="entity-list-item">
                    <b-row>
                        <b-col sm="2">
                            <div class="entity-logo">
                                <img src="../../../assets/images/link3-logo.jpg" alt="">
                            </div>
                        </b-col>
                        <b-col sm="10">
                            <div class="entity-details">
                                <h4>link3 technologies limited</h4>
                                <small class="text-muted">Establishment: January 2006</small>
                                <p>
                                    Syntech Solution Ltd is CMMI Level 3, ISO 9001 and ISO 27001 certified software engineering and
                                    consultancy firm focused
                                    on Web Based Application, & software development, offshore web design, Website
                                </p>
                            </div>
                        </b-col>
                    </b-row>
                    <div class="entity-view-overlay">
                        <button class="btn" @click="swichToProfile">View Profile</button>
                    </div>
                </b-card>
                <b-card class="entity-list-item">
                    <b-row>
                        <b-col sm="2">
                            <div class="entity-logo">
                                <img src="../../../assets/images/agni.jpg" alt="">
                            </div>
                        </b-col>
                        <b-col sm="10">
                            <div class="entity-details">
                                <h4>Agni Systems Ltd.</h4>
                                <small class="text-muted">Establishment: January 2006</small>
                                <p>
                                    Syntech Solution Ltd is CMMI Level 3, ISO 9001 and ISO 27001 certified software engineering and
                                    consultancy firm focused
                                    on Web Based Application, & software development, offshore web design, Website
                                </p>
                            </div>
                        </b-col>
                    </b-row>
                    <div class="entity-view-overlay">
                        <button class="btn" @click="swichToProfile">View Profile</button>
                    </div>
                </b-card>
                <b-card class="entity-list-item">
                    <b-row>
                        <b-col sm="2">
                            <div class="entity-logo">
                                <img src="../../../assets/images/BOL-Logo.png" alt="">
                            </div>
                        </b-col>
                        <b-col sm="10">
                            <div class="entity-details">
                                <h4>Bangladesh export import company ltd.</h4>
                                <small class="text-muted">Establishment: January 2006</small>
                                <p>
                                    Syntech Solution Ltd is CMMI Level 3, ISO 9001 and ISO 27001 certified software engineering and
                                    consultancy firm focused
                                    on Web Based Application, & software development, offshore web design, Website
                                </p>
                            </div>
                        </b-col>
                    </b-row>
                    <div class="entity-view-overlay">
                        <button class="btn" @click="swichToProfile">View Profile</button>
                    </div>
                </b-card>
            </div>
        </b-container>
    </main>
</template>
<script>
export default {
    name: 'Profile',
    data () {
        return {
            foods: [{ text: 'Select One', value: null }, 'Carrots', 'Beans', 'Tomatoes', 'Corn'],
            show: true
        }
    },
    methods: {
        swichToProfile () {
            this.$router.push('/rjsc-portal-entity/profile')
        }
    }
}
</script>
<style>
.main-search-section {
    padding: 1.5rem 0;
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    background-image: linear-gradient(to bottom, rgba(0, 56, 27, 0.52), rgba(0, 56, 27, 0.52)), url(https://images.pexels.com/photos/531880/pexels-photo-531880.jpeg);
    background-position: center;
    background-repeat: no-repeat;
}
h1 {
    color: var(--light);
    display: block;
    margin: 0 auto 10px auto;
    text-align: center;
    text-transform: uppercase;
    font-size: 1.92em;
    font-weight: 600;
}
.search-box {
    position: relative;
    width: 100%;
    max-width: 460px;
    height: 40px;
    margin: 0 auto;
}
.search-icon{
    color: var(--rjsc-brand);
    position: absolute;
    left: 10px;
    top: 50%;
    transform: translateY(-50%);
    font-size: 1.22em;
}
#search {
    position: absolute;
    top: 0;
    left: 0;
    border-radius: 5px;
    border: 3px solid var(--rjsc-brand);
    width: 100%;
    height: 100%;
    background: rgba(255, 255, 255, 0.905);
    padding: 0 15px;
    font-size: 1em;
    font-weight: 400;
    outline: none;
}
#search:focus{
    width: 100%;
}
.main-search-section .advance-search{
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
}
.main-search-section .advance-search .advance-search-options{
    margin-top: 1rem;
    padding: 5px;
}
.main-search-section .advance-search .advance-search-options label{
    color: var(--light);
}
.main-search-section .advance-search .advance-search-options button{
    color: #fff;
    padding: 4.5px;
    border-radius: 5px;
    border: none;
    background: var(--bs-body-color);
}
.main-search-section .advance-search .advance-search-options .latter-shorting{
    margin: .5rem;
}
.main-search-section .advance-search .advance-search-options .latter-shorting ul{
    display: flex;
    justify-content: center;
    align-items: center;
    flex-wrap: wrap;
}
.main-search-section .advance-search .advance-search-options .latter-shorting ul li{
    margin: 0 .2rem;
}
.main-search-section .advance-search .advance-search-options .latter-shorting ul li a{
    padding: 5px;
    color: var(--rjsc-brand);
    width: 1.6rem;
    height: 1.6rem;
    border-radius: 4px;
    display: flex;
    background: var(--light);
    justify-content: center;
    align-items: center;
}
.entity-list{
    margin-top: 1rem;
}
.entity-list .entity-list-item{
    margin-bottom: 1rem;
    position: relative;
    background: linear-gradient(to left, rgb(231 255 242) 10%, rgb(231 255 242) 34%, rgb(255 255 255) 81%, rgb(236 255 245) 88%);
    box-shadow: rgb(0 0 0 / 15%) 1.95px 1.95px 2.6px;
}
.entity-list .entity-list-item .entity-logo{
    display: flex;
    flex-direction: column;
    align-items: center;
}
.entity-list .entity-list-item .entity-logo img{
    width: 90%;
    max-width: 10rem;
    height: auto;
}
.entity-list .entity-list-item .entity-details{
    padding-left: 10px;
    border-left: 1px solid #eee;
}
.entity-list .entity-list-item .entity-details h4{
    text-transform: capitalize;
}
.entity-list .entity-list-item:hover .entity-view-overlay{
    opacity: 1;
    visibility: visible;
}
.entity-list .entity-list-item .entity-view-overlay{
    position: absolute;
    top: 0;
    left: 0;
    opacity: 0;
    visibility: hidden;
    width: 100%;
    height: 100%;
    border-radius: 3px;
    display: flex;
    justify-content: center;
    align-items: center;
    background: rgba(255, 255, 255, 0.401);
    transition: all .4s linear;
}
.entity-list .entity-list-item .entity-view-overlay button{
    color: var(--light);
    background: var(--rjsc-brand);
}
.entity-list .entity-list-item .entity-view-overlay button:hover{
    color: var(--light);
    background: rgb(3, 171, 90);
}
</style>
