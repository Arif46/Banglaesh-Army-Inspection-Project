<template>
    <b-container>
        <b-row>
            <b-col class="text-center">
                <img src="@/assets/images/404-error.svg" class="img-fluid" width="400" alt="404 Not Found">
                <p>Opps! Page Not Found</p>
                <div class="d-flex justify-content-center mt-4">
                    <b-button @click="$router.go(-1)" type="button" class="mr-2">Go Back</b-button>
                    <b-button @click="$router.push('/portal/home')">Go to Home</b-button>
                </div>
            </b-col>
        </b-row>
    </b-container>
</template>
