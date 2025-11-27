function Meta(meta)
  if meta.thesis then
    local function stringify(el)
      return pandoc.utils.stringify(el)
    end

    local course = meta.thesis.course and stringify(meta.thesis.course) or ""
    local degree = meta.thesis.degree and stringify(meta.thesis.degree) or ""

    if not meta.thesis.message then
      
      -- frase inicial conforme o grau
      local intro
      if degree == "Bacharel" then
        intro = "Texto apresentado ao Colegiado do Curso de Graduação em "
      elseif degree == "Especialista" then
        intro = "Texto apresentado ao Colegiado do Curso de Especialização em "
      else
        intro = "Texto apresentado ao Programa de Pós-Graduação em "
      end

      local full_message =
        intro .. course ..
        " como requisito parcial para obtenção do título de " ..
        degree .. " em " .. course .. "."

      -- mensagem justificada: RawBlock LaTeX
      meta.thesis.message = pandoc.RawBlock("latex",
        "\\justifying\n" .. full_message
      )
    end
  end
  
  return meta
end
