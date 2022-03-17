<template>
  <div>
    <b-row>
      <b-col>
        <b-list-group>
          <b-list-item
            v-for="user in allUsers"
            :key="user.userid"
            :name="user.userid"
            role="tab"
          >
          <b-card>
            <b-card-text>
              <strong>{{user.userfirstname}} {{user.userlastname}}</strong>
              <br/> {{user.useremail}} | {{user.useremail}}
              <br/>
                <span class="mt-2">
                  <span v-if="user.isadmin">
                    <b-btn
                    class="mr-2"
                      variant="primary"
                      @click="toggleAdmin(user.userid)"
                    >
                      Remove Admin Status
                    </b-btn>
                  </span>
                  <span v-else>
                    <b-btn
                    class="mr-2"
                      outlined
                      variant="outline-primary"
                      @click="toggleAdmin(user.userid)"
                    >
                      Give Admin Status
                    </b-btn>
                  </span>
                  <b-btn
                    class="mx-2"
                    variant="danger"
                    @click="deleteUser(user.userid)"
                  >
                    Delete User
                  </b-btn>
                </span>
            </b-card-text>
          </b-card>
          </b-list-item>
        </b-list-group>
      </b-col>
    </b-row>
  </div>
</template>

<script>
import Api from "../api";

export default {
  name: "UserList",
  props: {
    allUsers: {
      type: Array,
      required: true,
    }
  },
  methods: {
    toggleAdmin(userid) {
      Api.toggleAdminStatus(userid)
      .then(this.$router.go())
      .catch(() => {
        console.log("Toggle Admin Failed")
      })
    },

    deleteUser(userid) {
      Api.deleteUser(userid)
      .then(this.$router.go())
      .catch(() => {
        console.log("User Not Deleted")
      })
    }
  }
};
</script>
