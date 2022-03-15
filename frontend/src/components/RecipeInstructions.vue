<template>
  <div>
    <b-card
      border-variant="dark"
      header="Instructions"
      header-bg-variant="secondary"
      header-text-variant="white"
    >
      <div v-if="editting">
        
          
          <b-list-group flush>
            <b-form-group>
              <b-list-group-item v-for="(task, number) of this.formattedInstructions" :key="number">
                <b-input-group>{{number+1}}. 
                  <b-form-input 
                  v-bind="formattedInstructions[number]" 
                  :value="task"
                  ></b-form-input>
                  </b-input-group>
              </b-list-group-item>
            </b-form-group>
          </b-list-group>
          <b-button @click="toggleEdit" variant="info">Cancel</b-button> <b-button @click="toggleEdit" variant="info">Save</b-button>
        
      </div>
      <div v-else>
        <b-list-group flush>
          <b-list-group-item v-for="(task, number) of this.formattedInstructions" :key="number">{{number+1}}. {{task}}</b-list-group-item>
        </b-list-group>
        <b-button @click="toggleEdit" variant="info">Edit</b-button>
      </div>
    </b-card>
  </div>
</template>

<script>
import Api from "../api"

export default {
  name: "AddNewRecipe",
  props: {
    instructions: {
      type: String,
      required: true
    }
  },
  data: function () {
    return {
      loading: false,
      editting: false,
      test: "hello, there, you are a, fool",
      formattedInstructions: []
    };
  },
  created: function () {
    const newInstructions = this.test.split(',') // TODO: Switch this to this.instructions
    this.formattedInstructions = [...newInstructions]
  },
  methods: {
    toggleEdit() {
      this.editting = !this.editting
    },
    handleCreate() {
      Api.createRecipe(this.recipeName, this.recipeDescription, this.recipeInstructions, this.isPrivate, this.userId)
    }
  }
};
</script>
