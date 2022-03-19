<template>
  <div>
    <b-card
      border-variant="dark"
      header="Ingredients"
      header-bg-variant="secondary"
      header-text-variant="white"
    >
      <div v-if="editting && managingRecipe">
          <b-list-group flush>
            <b-form-group>

              <b-list-group-item>
                  <b-input-group>
                    <b-form-input disabled value="5"></b-form-input>
                    <b-form-input disabled value="Cups"></b-form-input>
                    <b-form-input disabled value="Flour"></b-form-input>
                  </b-input-group>
              </b-list-group-item>

              <b-list-group-item v-for="(value, key) in this.recipeIngredients" :key="key">
                <b-input-group>
                        <b-form-input 
                        id="amount"
                        v-model="recipeIngredients[key].ingredientamount" 
                        :value="value.ingredientamount"
                        @change="addEmptyRow"
                        type="number"
                        ></b-form-input> 

                        <b-form-input 
                        id="measurement"
                        v-model="recipeIngredients[key].ingredientmeasurement" 
                        :value="value.ingredientmeasurement"
                        @change="addEmptyRow"
                        ></b-form-input>

                        <b-form-select id="item" v-model="recipeIngredients[key].item" :options="options" @change="addEmptyRow"></b-form-select>

                        <b-button @click="removeFromArray(value.ingredientid)" v-if="value.ingredientid" title="Remove Ingredient" class="rounded bg-secondary p-1">
                          <b-icon icon="x" variant="light" aria-hidden="true"></b-icon>
                        </b-button>
                    
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
              <AddItem :existingItems="allItems" v-on:itemCreated="getAllItems"/>
            </b-modal>

          <br/>
          <b-button @click="toggleEdit" variant="danger">Cancel</b-button> <b-button @click="modifyIngredients" variant="success">Save</b-button> 
      </div>
      <div v-else>
        <b-list-group flush>
          <b-list-group-item v-for="value of this.recipeIngredients" :key="value.ingredientid">{{value.ingredientamount}} {{value.ingredientmeasurement}} {{value.item.name}}</b-list-group-item>
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
    options: function () {
      const optionsArray = this.allItems.map(item => {
        return {
          text: item.itemname,
          value: {
            id: item.itemid,
            name: item.itemname
          }
        }
      })
      //sort array by text
      return optionsArray.sort(function(a, b) {
        const nameA = a.text.toUpperCase(); // ignore upper and lowercase
        const nameB = b.text.toUpperCase(); // ignore upper and lowercase
        if (nameA < nameB) {
          return -1;
        }
        if (nameA > nameB) {
          return 1;
        }
        // names must be equal
        return 0;
      });
    }
  },
  data: function () {
    return {
      loading: false,
      editting: false,
      allItems: [],
      recipeIngredients: [],
      originalIngredients: []
    };
  },
  created: function () {
    this.getRecipeIngredients()
  },
  methods: {
    toggleEdit() {
      this.editting = !this.editting
      if (this.editting) {
        this.getAllItems()
        this.addEmptyRow()
      } else {
        this.removeEmptyRow()
      }
    },
    formatter(ingredients){
      return ingredients.map(ingredient => {
        return {
          recipeid: this.$route.params.recipeid,
          ingredientamount: ingredient.ingredientamount,
          ingredientmeasurement: ingredient.ingredientmeasurement,
          item: {
            id: ingredient.itemid,
            name: ingredient.itemname
          },
          ingredientid: ingredient.ingredientid
        }
      })
    },
    getRecipeIngredients(){
      Api.getRecipeIngredients(this.recipeId).then(res => {
        const formattedData = this.formatter(res.data)
        this.recipeIngredients = [...formattedData]
        this.originalIngredients = [...formattedData]
        if (this.editting) this.addEmptyRow()
      })
    },
    modifyIngredients (){
      this.removeEmptyRow()
      this.createIngredient()
      this.getRecipeIngredients()
      this.toggleEdit()
    },
    addEmptyRow (){
      console.log('adding empty row')
      const isEmpty = value => value === '' || value === null || value === undefined
      const alreadyHasEmptyRow = this.recipeIngredients.some(value => isEmpty(value.ingredientamount) && isEmpty(value.ingredientmeasurement) && isEmpty(value.item.name))
      if (!alreadyHasEmptyRow){
        const emptyRow = {
          recipeid: this.$route.params.recipeid,
          ingredientamount: '',
          ingredientmeasurement: '',
          item: {
            id: '',
            name: ''
          },
          ingredientid: ''
        }
        this.recipeIngredients = [
          ...this.recipeIngredients,
          emptyRow
        ]
      }
      console.log('finished adding row')
    },
    removeEmptyRow(){
      console.log('removing row')
      const isEmpty = value => value === '' || value === null || value === undefined
      const emptyRow = value => isEmpty(value.ingredientamount) && isEmpty(value.ingredientmeasurement) && isEmpty(value.item.name)
      const newArray = this.recipeIngredients.filter(item => !emptyRow(item))
      this.recipeIngredients = [...newArray]
      console.log('done removing row')
    },
    getAllItems(){
      Api.getAllItems().then(res => {
        this.allItems = [...res.data]
      })
    },
    createIngredient(){
      const ingredientToSave = this.recipeIngredients.filter(addedItem => { if (!this.originalIngredients.includes(addedItem)) return addedItem})
      for (const item of ingredientToSave) {
        Api.createIngredient(item.ingredientamount, item.ingredientmeasurement, item.item.id, this.recipeId).then(() => {
          console.log('successfully added ', item)
        })
      }
      return Promise.resolve(true)
    },
    removeFromArray(ingredientId){
      Api.deleteIngredient(ingredientId).then(() => {
        this.getRecipeIngredients()
      })
    }
  }
};
</script>
