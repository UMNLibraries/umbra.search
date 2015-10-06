class UpsertRecords
  def self.call(records)
    inserts, updates = extract_upserts(records)
    Record.create(inserts.values)               if inserts.length > 0
    Record.update(updates.keys, updates.values) if updates.length > 0
  end

  def self.extract_upserts(upserts)
    upserts = keyed_upsert(upserts)
    updatables = Record.with_record_hashes(upserts.keys)
    updates    = {}
    updatables.each do |up|
      updates[up.record_hash] = upserts[up.record_hash]
      upserts.delete(up.record_hash)
    end
    [upserts, updates]
  end

  def self.keyed_upsert(upserts)
    keyed = {}
    upserts.each do |upsert| 
      keyed[upsert['record_hash']] = upsert
    end
    keyed
  end
end