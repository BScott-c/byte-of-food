<template>
  <div>
    <b-card
      border-variant="dark"
      header="Equipment"
      header-bg-variant="secondary"
      header-text-variant="white"
    >
      <div v-if="editting">
        {{this.selected}}
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
              <b-button v-b-modal.equipment-modal>Add an item</b-button>
            </div>

            <b-modal id="equipment-modal" title="Add Equipment">
              <AddEquipment :existingEquipment="allEquipment" v-on:equipmentCreated="handleEquipmentCreated($event)"/>
            </b-modal>

          </b-list-group>
          <b-button @click="cancel" variant="danger">Cancel</b-button> <b-button @click="handleSave" variant="success">Save</b-button> 
      </div>
      <div v-else>
        <b-list-group flush>
          <b-list-group-item v-for="item of this.recipeEquipment" :key="item.equipmentname">{{item.equipmentname}}</b-list-group-item>
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
        console.log(item)
        return {
          text: item.equipmentname,
          value: item
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
    // selected: {
    //   get: function (){
    //     return [...this.equipmentAdded]
    //   },
    //   set: function (value) {
    //     this.equipmentAdded = [...value]
    //   }
    // },
    recipeId: function (){
      return this.$route.params.recipeid
    }
  },
  data: function () {
    return {
      loading: false,
      editting: false,
      allEquipment: [],
      equipmentAdded: [],
      recipeEquipment: [],
      selected: []
    };
  },
  created: function () {
    this.getEquipmentInfo().then(() => {
      this.equipmentAdded = [...this.recipeEquipment]
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
    async getEquipmentList(){
      const res = await Api.getEquipment()
      this.allEquipment = [...res.data]
    },
    async getEquipmentInfo(){
      const equipmentRes = await Api.getRecipeEquipment(this.recipeId)
      this.recipeEquipment = [...equipmentRes.data]
    },
    async handleEquipmentCreated(event){
      // update the list
      await this.getEquipmentList()
      console.log(event)
      // TODO: select the equipment added
      // const addedItem = this.options.find(item => item.text === event)
      // if (addedItem) {
      //   this.selected = [...this.equipmentAdded, addedItem]
      //   console.log('selected after: ', this.selected)
      // }
      // else console.error('Item was not found and could not be added', event)
    },
    handleSave(){
      this.saveEquipment()
      this.removeEquipment()
      this.getEquipmentList()
      this.toggleEdit()
    },
    saveEquipment(){
      const equipmentToSave = this.equipmentAdded.filter(addedItem => {
        if (this.recipeEquipment.find(recipeItem => addedItem.equipmentid === recipeItem.equipmentid)) {
          console.info('do not add ', addedItem.equipmentname)
        } else {
          return addedItem
        }
      })
      console.info('adding: ', equipmentToSave)
      equipmentToSave.forEach(item => {
        Api.addEquipmentToRecipe(item.equipmentid, this.recipeId)
      });
    },
    removeEquipment(){
      const equipmentToRemove = this.recipeEquipment.filter(recipeItem => {
        if (this.equipmentAdded.find(addedItem => addedItem.equipmentid === recipeItem.equipmentid)) {
          console.info('do not remove ', recipeItem.equipmentname)
        } else {
          return recipeItem
        }
      })
      console.info('removing: ', equipmentToRemove)
      equipmentToRemove.forEach(item => {
        Api.removeEquipmentFromRecipe(item.equipmentid, this.recipeId)
      });
    }
  }
};
</script>
