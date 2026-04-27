type NomeAluno = String
type MediaNota = Int
type Aluno = (NomeAluno, MediaNota) -- nome, nota

type Turma = [Aluno]

aprovados :: Turma -> Int -> [NomeAluno]
aprovados tma nota = [nome | (nome, media) <- tma ,media >= nota]

-- Exercicio
type Ponto = (Float, Float, Float)

distancia :: Ponto -> Ponto -> Float
distancia (x1, y1, z1) (x2, y2, z2) = sqrt ( dx^2 + dy^2 + dz^2 )
    where
        dx = x1 - x2
        dy = y1 - y2
        dz = z1 - z2
