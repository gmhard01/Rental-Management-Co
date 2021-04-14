<template>
    <div class="applicationTile">
        <div class="leftApplication">
            <div>Applicant Name: {{application.firstName}} {{application.lastName}}</div>
            <div>Phone: application.phone</div>
        </div>
        <div class="applicationBtns">
            <button>Approve</button>
            <button>Decline</button>
        </div>
    </div>
</template>

<script>
export default {
    name: "applicationTile",
    props: ["application"],
}
</script>

<style>
.applicationTile{
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
  font-family: "Oswald", "Arial", "Helvetica", "sans-serif";
}

.leftApplication{
    display: flex;
    flex-direction: column;
    justify-content: space-around;
    align-items: center;
}
.applicationBtns{
    display: flex;
    flex-direction: column;
    justify-content: space-around;
    align-items: center;
}
</style>