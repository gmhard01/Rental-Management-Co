<template>
    <div class="upcomingPaymentTile">
        <div>Payment due on  {{payment.dueDate.slice(0,9)}} for ${{parseFloat(payment.amountDue).toFixed(2)}} </div>
    </div>
</template>

<script>
export default {
    name: "upcomingPaymentTile",
    props: ['payment'],
}
</script>

<style>
.upcomingPaymentTile{
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