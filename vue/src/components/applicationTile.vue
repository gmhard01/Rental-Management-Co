<template>
    <div class="applicationTile">
        <div class="leftApplication">
            <div>Applicant Name: {{application.applicantFirstName}} {{application.applicantLastName}}</div>
            <div>Phone: {{application.applicantPhone}}</div>
        </div>
        <div class="applicationBtns">
            <button id="approve">Approve</button>
            <button id="decline">Decline</button>
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
  justify-content: space-between;
  align-items: center;
  font-family: "Oswald", "Arial", "Helvetica", "sans-serif";
}

.leftApplication{
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    margin: 1rem;
    min-width: 45rem;
    font-size: 1.8rem;
}
.applicationBtns{
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    min-width: 20rem;
}

#approve, #decline{
    height: 3rem;
    font-size: 2rem;
    border-radius: 1rem;
}
</style>