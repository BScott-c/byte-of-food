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
              <b-list-group-item v-for="item of this.formattedInstructions" :key="item.ordinal">
                <b-input-group>{{item.ordinal}}. 
                    <b-form-input 
                    v-model="formattedInstructions[item.ordinal-1].instruction" 
                    :value="item.instruction"
                    @change="addEmptyObject"
                    ></b-form-input>
                  </b-input-group>
              </b-list-group-item>
            </b-form-group>
          </b-list-group>
          <b-button @click="cancel" variant="danger">Cancel</b-button> <b-button @click="modifyInstructions" variant="success">Save</b-button> 
      </div>
      <div v-else>
        <b-list-group flush>
          <b-list-group-item v-for="item of this.formattedInstructions" :key="item.ordinal">{{item.ordinal}}. {{item.instruction}}</b-list-group-item>
        </b-list-group>
        <b-button v-if="this.managingRecipe" @click="toggleEdit" variant="info">Edit</b-button>
      </div>
    </b-card>
  </div>
</template>

<script>
import Api from "../api"

export default {
  name: "RecipeInstructions",
  props: {
    instructions: {
      type: String,
      required: true,
      default: ""
    },
    managingRecipe: {
      type: Boolean,
      required: true
    }
  },
  data: function () {
    return {
      loading: false,
      editting: false,
      formattedInstructions: [],
      oldInstructions: []
    };
  },
  created: function () {
    const newInstructions = this.instructions.split(',')
    this.convertArrayToObject(newInstructions)
  },
  methods: {
    toggleEdit() {
      this.editting = !this.editting
      if (this.editting){
        this.addEmptyObject()
      } else {
        this.removeEmptyObjects()
      }
    },
    cancel(){
      this.formattedInstructions = [...this.oldInstructions]
      this.toggleEdit()
    },
    convertArrayToObject (arrayOfStrings) {
      let newArray = [];
      for (const [key, value] of arrayOfStrings.entries()) {
        newArray = [
          ...newArray,
          {
            ordinal: key+1,
            instruction: value
          }
        ]
      }
      this.formattedInstructions = [...newArray]
      this.oldInstructions = [...newArray]
    },
    convertArrayToString (arrayOfObjects) {
      const arrayOfStrings = arrayOfObjects.map(item => item.instruction)
      return arrayOfStrings.join()
    },
    modifyInstructions (){
      this.removeEmptyObjects()
      const newInstructions = this.convertArrayToString(this.formattedInstructions)
      const updateBody = {
        recipeinstructions: newInstructions
      }
      Api.updateRecipe(this.$route.params.recipeid, updateBody).then(() => {
        this.instructions = newInstructions
      })
      this.toggleEdit()
    },
    addEmptyObject (){
      const alreadyHasEmptyObject = this.formattedInstructions.some(value => value.instruction === "")
      if (!alreadyHasEmptyObject){
        const emptyObject = {
              ordinal: this.formattedInstructions.length+1,
              instruction: ''
            }
        this.formattedInstructions = [
            ...this.formattedInstructions,
            emptyObject
          ]
      }
    },
    removeEmptyObjects(){
      const newArray = this.formattedInstructions.filter(item => item.instruction !== "")
      // correct any issues in ordinal (i.e. if a middle object was removed)
      for (const [key, value] of newArray.entries()) {
        if (key+1 !== value.ordinal) value.ordinal = key+1
      }
      this.formattedInstructions = [...newArray]
    }
  }
};
</script>
