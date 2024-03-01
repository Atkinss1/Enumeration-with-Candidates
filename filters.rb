# In this file we define the methods to help filter out candidates
# This way, we keep these methods separated from other potential parts of the program

def find(candidate, id)
  if candidate[:id] == id
    return candidate
  end
  nil
end

def experienced?(candidate)
  candidate[:years_of_experience] >= 2
end

def qualified_candidates(candidates)
  qualified = []

  candidates.each do |candidate|
    isQualified = true

    unless experienced?(candidate)
      isQualified = false
      next
    end

    unless github_points(candidate) > 100
      isQualified = false
      next
    end

    unless programming_languages(candidate, "Python", "Ruby")
      isQualified = false
      next
    end

    unless applied(candidate)
      isQualified = false
      next
    end

    unless applicant_age(candidate)
      isQualified = false
      next
    end

    qualified.push(candidate) if isQualified
  end

  qualified
end

  
  # More methods will go below

  def github_points(candidate)
    return candidate[:github_points]
  end

  def programming_languages(candidate, *languages)
    languages.any? do |lang|
      candidate[:languages].include?(lang)
    end
  end

  def applied(candidate)
    applied_date = candidate[:date_applied]
    days_since = (Date.today - applied_date).to_i
    return days_since < 15
  end

  def applicant_age(candidate)
    candidate[:age] >= 18
  end

  def ordered_by_qualifications(candidates)
    candidates.sort_by! do |candidate|
      [-candidate[:years_of_experience], -candidate[:github_points]]
    end
  end


