<template>
    <div class="transactionTile">
        <div>Applicant Name: application.firstName application.lastName</div>
        <div>Phone: application.phone</div>
    </div>
</template>

<script>
export default {
    name: "applicationTile",
}
</script>

<style>
.transactionTile{
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
</style>