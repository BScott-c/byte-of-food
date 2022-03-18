<template>
  <div>
    <b-card
      border-variant="dark"
      header="Equipment"
      header-bg-variant="secondary"
      header-text-variant="white"
    >
      <div v-if="editting && managingRecipe">
          <b-list-group flush>
            <b-form-group
              label="Select All Equipment Used:"
              v-slot="{ ariaDescribedby }"
            >
              <b-form-checkbox-group
                v-model="selected"
                :options="options"
                :aria-describedby="ariaDescribedby"
                name="flavour-2a"
                stacked
              ></b-form-checkbox-group>
            </b-form-group>

            <br />
            <div>
              <p>Don't see what you need?</p>
              <b-button v-b-modal.equipment-modal>Add an Item</b-button>
            </div>
            <br /><br />

            <b-modal id="equipment-modal" title="Add Equipment">
              <AddEquipment :existingEquipment="allEquipment" v-on:equipmentCreated="handleEquipmentCreated($event)"/>
            </b-modal>

            <span
              v-show="loading"
              class="spinner-border spinner-border-sm"
            ></span>

          </b-list-group>
        <div>
            <b-button @click="cancel" class="ml-2" variant="danger">Cancel</b-button>
            <b-button @click="handleSave" class="ml-2" variant="success">Save</b-button> 
            <span
              v-show="loading"
              class="spinner-border spinner-border-sm"
            ></span>
        </div>
      

           
      </div>
      <div v-else>
        <b-list-group flush>
          <b-list-group-item v-for="item of this.alphabetizedRecipeEquipment" :key="item.equipmentname">{{item.equipmentname}}</b-list-group-item>
        </b-list-group>
        <b-button v-if="this.managingRecipe" @click="toggleEdit" variant="info">Edit</b-button>
      </div>
    </b-card>
  </div>
</template>

<script>
import Api from "../api"
import AddEquipment from "./AddEquipment.vue"

export default {
  name: "Equipment",
  components: {
    AddEquipment
  },
  props: {
    managingRecipe: {
      type: Boolean,
      required: true
    }
  },
  computed: {
    options: function (){
      const optionsArray = this.allEquipment.map(item => {
        return {
          text: item.equipmentname,
          value: {
            recipeid: this.$route.params.recipeid,
            ...item
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
    },
    alphabetizedRecipeEquipment: function () {
      //sort array by text
      const copyOfRecipeEquipment = [...this.recipeEquipment]
      return copyOfRecipeEquipment.sort(function(a, b) {
        const nameA = a.equipmentname.toUpperCase(); // ignore upper and lowercase
        const nameB = b.equipmentname.toUpperCase(); // ignore upper and lowercase
        if (nameA < nameB) {
          return -1;
        }
        if (nameA > nameB) {
          return 1;
        }
        // names must be equal
        return 0;
      });
    },
    recipeId: function (){
      return this.$route.params.recipeid
    }
  },
  data: function () {
    return {
      loading: false,
      editting: false,
      allEquipment: [],
      recipeEquipment: [],
      selected: []
    };
  },
  created: function () {
    this.getEquipmentInfo().then(() => {
      this.selected = [...this.recipeEquipment]
    })
  },
  methods: {
    toggleEdit() {
      this.editting = !this.editting
      if (this.editting){
        this.getEquipmentList()
      }
    },
    cancel(){
      this.toggleEdit()
    },
    getEquipmentList(){
      return new Promise((resolve, reject) => {
          Api.getEquipment().then(res => {
            this.allEquipment = [...res.data]
            resolve(true)
          }).catch(e => {
            console.error('Problem getting equipment list: ', e)
            reject(false)
          })
      })
    },
    getEquipmentInfo(){
      return new Promise((resolve, reject) => {
          Api.getRecipeEquipment(this.recipeId).then(res => {
            this.recipeEquipment = [...res.data]
            resolve(true)
          }).catch(e => {
            console.error('Problem getting equipment info: ', e)
            reject(false)
          })
      })
    },
    handleEquipmentCreated(event){
      // update the list
      this.getEquipmentList()
      console.log(event)
      /*
      .then(() => {
        // TODO: select the equipment added
        
      const addedItem = this.options.find(item => item.text === event)
      if (addedItem) {
        this.selected = [...this.selected, addedItem]
      }
      else console.error('Item was not found and could not be added', event)
      })
      */
    },
    async handleSave(){
      this.loading = true
      await this.saveEquipment()
      await this.removeEquipment()
      // WAIT
      setTimeout(() => {
        this.getEquipmentInfo()
        this.toggleEdit()
        this.loading = false
      }, 500);
    },
    saveEquipment(){
      const equipmentToSave = this.selected.filter(addedItem => { if (!this.recipeEquipment.includes(addedItem)) return addedItem})
      for (const item of equipmentToSave) {
        Api.addEquipmentToRecipe(item.equipmentid, this.recipeId).then(() => {
          console.log('successfully added ', item.equipmentname)
        })
      }
      return Promise.resolve(true)
    },
    removeEquipment(){
      const equipmentToRemove = this.recipeEquipment.filter(recipeItem => { if (!this.selected.includes(recipeItem)) return recipeItem })
      for (const item of equipmentToRemove) {
        Api.removeEquipmentFromRecipe(item.equipmentid, this.recipeId).then(() => {
          console.log('successfully removed ', item.equipmentname)
        })
      }
      return Promise.resolve(true)
    }
  }
};
</script>
