<template>
  <div>
    <div>
      <form name="form" @submit.prevent="handleCreate">
        <div class="form-group">
          <label for="itemName">Item *</label>
          <input
            v-model="itemName"
            type="text"
            class="form-control"
            name="itemName"
            required
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
            <span>Add Item</span>
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
  name: "AddNewItem",
  data: function () {
    return {
      loading: false,
      itemName: "",
      errors: []
    };
  },
  created: function () {
    this.getAllItems()
  },
  methods: {
    async handleCreate(e) {
      this.isValid()
      if (!this.errors.length) {
        await Api.createItem(this.itemName)
        this.getAllItems()
        this.$emit('itemCreated')
      }
      e.preventDefault()
    },
    getAllItems (){
      Api.getAllItems().then(res => {
        this.existingItems = [...res.data]
        return Promise.resolve(true)
      })
    },
    isValid (){
      const equipmentErrors = []
      if (this.existingItems.find(item => item.itemname.toLowerCase() === this.itemName.toLowerCase())) {
        equipmentErrors.push({id:'nameError', message: 'That item has already been added. Please go back and select it.'})
      }
      this.errors = [...equipmentErrors]
    }
  }
};
</script>
