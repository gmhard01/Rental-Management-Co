USE final_capstone
GO

UPDATE payment_schedule SET past_due = CASE WHEN due_date < GETDATE() THEN 1 ELSE 0 END;
GO