<template>
    <div class="rjsc-login-wrapper">
    <h4 class="text-center mb-2 text-light">LOGIN</h4>
    <b-form v-if="show">
      <b-form-group
        id="input-group-1"
      >
        <b-form-input
          id="input-1"
          v-model="form.email"
          type="email"
          placeholder="Enter Email"
          required
        ></b-form-input>
      </b-form-group>

      <b-form-group id="input-group-2">
        <b-form-input
          id="input-2"
          v-model="form.pass"
          type="password"
          placeholder="Enter Password"
          required
        ></b-form-input>
      </b-form-group>

      <b-form-group id="input-group-4">
        <b-form-checkbox-group
          v-model="form.checked"
          id="checkboxes-4"
        >
          <b-form-checkbox value="me"><small>Remember Me</small></b-form-checkbox>
        </b-form-checkbox-group>
      </b-form-group>

      <b-button type="submit" class="lg-button gb-bordered hover-slide" id="log-btn" block variant="primary">LOGIN</b-button>
    </b-form>
    </div>
</template>
<script>
    export default {
        name: 'Login',
        data () {
            return {
                form: {
                    email: '',
                    pass: '',
                    checked: []
                },
                show: true
            }
        }
    }
</script>
<style>
  .rjsc-login-wrapper{
    font-family: poppins;
  }
    .login-form-btn{
        background-color: var(--rjsc-brand);
        border-color: transparent;
    }
</style>
