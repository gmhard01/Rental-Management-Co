<template>
    <div class="maintenanceTile">
        <div class="clientInfo">
            <div>Client Name: John Doe</div>
            <div>Client Phone: 555-555-5555</div>
        </div>
        <div class="maintDetails">
            <div>Description: Dude this stuff is MESSED up. Like it real bad over here. God help the guy who fixes this bathroom. I dont know how it got on the ceiling.</div>
        </div>
        <div v-if="this.$store.state.user.role=='maintenance'" class="btn">
            <input type="submit" class="submit" name="" value="In Progress">
            <input type="submit" class="submit" name="" value="Complete">
        </div>
        <div v-if="this.$store.state.user.role=='landlord'" class="landlordInputs">
            <input type="text" id="maintenanceUserName" class="assignWorker" placeholder="Maintenance Username" />
            <input type="submit" class="submitUser" name="" value="Assign">
        </div>
    </div>
</template>

<script>
export default {

}
</script>

<style>
.maintenanceTile{
  margin-top: .2rem;
  background-color: #fff;
  border-radius: 1.5rem;
  overflow: hidden;
  box-shadow: 0 3rem 6rem rgba(0, 0, 0, 0.589);
  margin-bottom: .5rem;
  padding: 20px;
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
  font-family: "Oswald", "Arial", "Helvetica", "sans-serif";
}

.clientInfo{
    min-width: 14rem;
}

.landlordInputs{
    display: flex;
    flex-direction: column;
    align-items: center;
}

.submitUser{
    background-color:rgb(182, 204, 236);
    border-radius: 1rem;
    height: 2rem;
    width: 7rem;
    font-size: 1rem;
}

.assignWorker{
    border-radius: .5rem;
    border-color: rgba(128, 128, 128, 0.377);
    font-size: 1.2rem;
    margin: .5rem;
}

.maintDetails{
    padding:2rem;
}
</style>