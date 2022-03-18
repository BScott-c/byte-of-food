<template>
  <div>
    <b-card
      border-variant="dark"
      header="Ingredients"
      header-bg-variant="secondary"
      header-text-variant="white"
    >
    <!-- {{this.recipeIngredients}} -->
    <br/><br/>
    {{this.formattedIngredients}}
      <div v-if="editting && managingRecipe">
          <b-list-group flush>
            <b-form-group>
              <b-list-group-item v-for="item of this.formattedIngredients" :key="item.ordinal">
                <b-input-group>
                     <b-form-input 
                    v-model="formattedIngredients[item.ordinal-1].ingredient.amount" 
                    :value="item.ingredient.amount"
                    @change="addEmptyRow"
                    type="number"
                    ></b-form-input> 


                    <b-form-input 
                    v-model="formattedIngredients[item.ordinal-1].ingredient.measurement" 
                    :value="item.ingredient.measurement"
                    @change="addEmptyRow"
                    ></b-form-input>

                    <b-form-input 
                    v-model="formattedIngredients[item.ordinal-1].item.name" 
                    :value="item.item.name"
                    @change="addEmptyRow"
                    ></b-form-input>
                  </b-input-group>
              </b-list-group-item>
            </b-form-group>
          </b-list-group>

          <br />
            <div>
              <p>Don't see the item you need?</p>
              <b-button v-b-modal.item-modal>Add an Item</b-button>
            </div>
            <br /><br />

            <b-modal id="item-modal" title="Add Item">
              <AddItem :existingItems="existingItems" v-on:itemCreated="handleCreatedItem($event)"/>
            </b-modal>

          <br/>
          <b-button @click="cancel" variant="danger">Cancel</b-button> <b-button @click="modifyIngredients" variant="success">Save</b-button> 
      </div>
      <div v-else>
        <b-list-group flush>
          <b-list-group-item v-for="item of this.formattedIngredients" :key="item.ordinal">{{item.ingredient.amount}} {{item.ingredient.measurement}} {{item.item.name}}</b-list-group-item>
        </b-list-group>
        <b-button v-if="this.managingRecipe" @click="toggleEdit" variant="info">Edit</b-button>
      </div>
    </b-card>
  </div>
</template>

<script>
import Api from "../api"
import AddItem from "./AddItem.vue"

export default {
  name: "Ingredients",
  components: {
    AddItem
  },
  props: {
    managingRecipe: {
      type: Boolean,
      required: true
    }
  },
  computed: {
    recipeId: function (){
      return this.$route.params.recipeid
    },
    formattedIngredients: function (){
      let newArray = []
      for (const [key, value] of this.recipeIngredients.entries()) {
        newArray = [
          ...newArray,
          {
            ordinal: key+1,
            ingredient: {
              amount: value.ingredientamount,
              measurement: value.ingredientmeasurement
            },
            item: {
              id: value.itemid,
              name: value.itemname
            }
          }
        ]
      }
      return  newArray
    }
  },
  data: function () {
    return {
      loading: false,
      editting: false,
      recipeIngredients: []
    };
  },
  created: function () {
    this.getRecipeIngredients()
    
  },
  methods: {
    toggleEdit() {
      this.editting = !this.editting
    },
    cancel(){
      this.toggleEdit()
    },
    getRecipeIngredients(){
      Api.getRecipeIngredients(this.recipeId).then(res => {
        this.recipeIngredients = [...res.data]
        const testData = [
          {
            "recipeid": 83,
            "itemname": "kiwi",
            "ingredientamount": "3",
            "ingredientmeasurement": null,
            "itemid": 1
          },
          {
            "recipeid": 83,
            "itemname": "Flour",
            "ingredientamount": "5",
            "ingredientmeasurement": "cups",
            "itemid": 2
          }
        ]
        if (!this.recipeIngredients.length) this.recipeIngredients = [...testData]
      })
    },
    handleCreatedItem(event){
      console.log('event: ', event)
    },
    modifyIngredients (){
      this.removeEmptyRow()
      // const newInstructions = this.convertArrayToString(this.formattedInstructions)
      // const updateBody = {
      //   recipeinstructions: newInstructions
      // }
      // Api.updateRecipe(this.$route.params.recipeid, updateBody).then(() => {
      //   this.instructions = newInstructions
      // })
      this.toggleEdit()
    },
    addEmptyRow (){
      const isEmpty = value => value === '' || value === null || value === undefined
      const alreadyHasEmptyRow = this.formattedIngredients.some(value => isEmpty(value.ingredient.amount) || isEmpty(value.ingredient.measurement) || isEmpty(value.item.name))
      if (!alreadyHasEmptyRow){
        const emptyRow = {
              ordinal: this.formattedIngredients.length+1,
              ingredient: {
                amount: '',
                measurement: ''
              },
              item: {
                id: '',
                name: ''
              }
            }
        this.formattedIngredients = [
            ...this.formattedIngredients,
            emptyRow
          ]
      }
    },
    removeEmptyRow(){
      const isEmpty = value => value === '' || value === null || value === undefined
      const emptyRow = value => isEmpty(value.ingredient.amount) || isEmpty(value.ingredient.measurement) || isEmpty(value.item.name)

      const newArray = this.formattedIngredients.filter(item => emptyRow(item))
      // correct any issues in ordinal (i.e. if a middle object was removed)
      for (const [key, value] of newArray.entries()) {
        if (key+1 !== value.ordinal) value.ordinal = key+1
      }
      this.formattedIngredients = [...newArray]
    }
  }
};
</script>
