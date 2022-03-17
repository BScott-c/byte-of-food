<template>
  <div>
    <div>
      <form name="form" @submit.prevent="handleCreate">
        <div class="form-group">
          <label for="equipmentName">Equipment Name *</label>
          <input
            v-model="equipmentName"
            type="text"
            class="form-control"
            name="equipmentName"
            required
          />
        </div>
        <div class="form-group">
          <label for="equipmentDescription">Equipment Description</label>
          <input
            v-model="equipmentDescription"
            type="text"
            class="form-control"
            name="equipmentDescription"
          />
        </div>

        <template v-for="error in this.errors">
          <b-alert show variant="danger" :key="error.id">{{error.message}}</b-alert>
        </template>

        <div class="form-group">
          <button class="btn btn-primary btn-block" type="submit" :disabled="loading">
            <span
              v-show="loading"
              class="spinner-border spinner-border-sm"
            ></span>
            <span>Create and Add Equipment</span>
          </button>
        </div>
        <br>
        <br>
      </form>
    </div>
  </div>
</template>

<script>
import Api from "../api"

export default {
  name: "AddNewRecipe",
  props: {
    existingEquipment: {
      type: Array,
      required: true
    }
  },
  computed: {
    recipeId: function (){
      return this.$route.params.recipeid
    }
  },
  data: function () {
    return {
      loading: false,
      equipmentName: "",
      equipmentDescription: "",
      errors: []
    };
  },
  methods: {
    async handleCreate(e) {
      this.isValid()
      if (!this.errors.length) {
        await Api.createEquipment(this.equipmentName, this.equipmentDescription)
        this.$emit('equipmentCreated', this.equipmentName)
      }
      e.preventDefault()
    },
    isValid (){
      const equipmentErrors = []
      if (this.existingEquipment.find(item => item.equipmentname.toLowerCase() === this.equipmentName.toLowerCase())) {
        equipmentErrors.push({id:'nameError', message: 'That equipment has already been added. Please go back and select it.'})
      }
      this.errors = [...equipmentErrors]
    }
  }
};
</script>
