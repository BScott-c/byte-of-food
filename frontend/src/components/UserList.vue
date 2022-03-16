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
              <span v-if="user.isadmin">
                <b-btn
                  variant="primary"
                  @click="toggleAdmin(user.userid)"
                >
                  Admin
                </b-btn>
              </span>
              <span v-else>
                <b-btn
                  outlined
                  variant="primary"
                  @click="toggleAdmin(user.userid)"
                >
                  Not Admin
                </b-btn>
              </span>
              <span>&nbsp;</span>
              <b-btn
                @click="deleteUser(user.userid)"
              >
                Delete
              </b-btn>
              {{user.useremail}}
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
