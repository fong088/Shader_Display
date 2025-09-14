Shader "ACG/Rim_Shader"
{

	Properties{
		_rimPower("Rim Power", Range(0.3, 10)) = 0.3
		_myColor("Color Pick", Color) = (1,1,1,1)
		//_myEmissionColor("Emission", Color) = ()
		//_myTex("Example Texture", 2D) = "white" {}
		
		}
	SubShader{
		CGPROGRAM
			#pragma surface surf Lambert

			float _rimPower;
			fixed4 _myColor;

			struct Input{
				float3 viewDir;
			};

			void surf(Input IN, inout SurfaceOutput o){
				half rim = dot(normalize(IN.viewDir), o.Normal); 
				half negativeRim = 1 - dot(normalize(IN.viewDir), o.Normal);
			
				o.Emission = pow(negativeRim, _rimPower) * _myColor;
				
			}
			

		ENDCG
		}
	}