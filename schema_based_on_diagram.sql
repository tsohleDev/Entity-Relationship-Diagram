-- create patients table
CREATE TABLE patients (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  date_of_birth DATE
);

-- create medical_history table
CREATE TABLE medical_history (
  id SERIAL PRIMARY KEY,
  patient_id INTEGER REFERENCES patients(id),
  admitted_at TIMESTAMP,
  status VARCHAR(255),
);

CREATE INDEX patient_id_index ON medical_history (patient_id);

-- create treatments table
CREATE TABLE treatments (
  id SERIAL PRIMARY KEY,
  type VARCHAR(255),
  name VARCHAR(255),
);

-- create a many to many relationship between treatments and medical_history
CREATE TABLE treatments_medical_history (
  id SERIAL PRIMARY KEY,
  treatment_id INTEGER REFERENCES treatments(id),
  medical_history_id INTEGER REFERENCES medical_history(id)
);

CREATE INDEX treatment_id_index ON treatments_medical_history (treatment_id);
CREATE INDEX medical_history_id_index ON treatments_medical_history (medical_history_id);

-- create invoices table
CREATE TABLE invoices (
  id SERIAL PRIMARY KEY,
  total_amount DECIMAL(10,2),
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INTEGER REFERENCES medical_history(id)
);

CREATE INDEX medical_history_id_index ON invoices (medical_history_id);

-- create invoice_items table
CREATE TABLE invoice_items (
  id SERIAL PRIMARY KEY,
  invoice_id INTEGER REFERENCES invoices(id),
  treatment_id INTEGER REFERENCES treatments(id),
  amount DECIMAL(10,2),
  quantity INTEGER
);

CREATE INDEX invoice_id_index ON invoice_items (invoice_id);
CREATE INDEX treatment_id_index ON invoice_items (treatment_id);
